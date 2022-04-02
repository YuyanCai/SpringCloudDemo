package com.caq.cloud.service.impl;

import com.caq.cloud.entities.CommonResult;
import com.caq.cloud.entities.Payment;
import com.caq.cloud.service.PaymentService;
import org.springframework.stereotype.Component;

@Component
public class PaymentFallbackService implements PaymentService {
    @Override
    public CommonResult<Payment> paymentSQL(Long id)
    {
        return new CommonResult<>(44444,"服务降级返回,---PaymentFallbackService",new Payment(id,"errorSerial"));
    }
}