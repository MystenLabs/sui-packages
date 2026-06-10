module 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::emergency {
    public entry fun emergency_withdraw<T0>(arg0: &mut 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::Vault<T0>, arg1: 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::shares::ShareReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::emergency_mode<T0>(arg0), 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::errors::not_emergency_mode());
        assert!(0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::shares::vault_id(&arg1) == 0x2::object::id<0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::Vault<T0>>(arg0), 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::errors::wrong_vault_id());
        let v0 = 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::shares::shares(&arg1);
        assert!(v0 > 0, 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::errors::insufficient_shares());
        let v1 = (0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::math::mul_div((0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::idle_usdc_value<T0>(arg0) as u128), v0, 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::total_shares<T0>(arg0)) as u64);
        0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::burn_shares_from_total<T0>(arg0, v0);
        let v2 = 0x2::tx_context::sender(arg3);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::take_idle<T0>(arg0, v1), arg3), v2);
        };
        0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::reduce_nav_scaled_saturating<T0>(arg0, 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::math::usdc_to_nav_scaled((v1 as u128)));
        0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::shares::destroy_receipt_forcibly(arg1);
        0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::events::emit_emergency_withdraw(0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::events::new_emergency_withdraw(0x2::object::id<0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::Vault<T0>>(arg0), v2, v0, v1, 0x58b0394ff6980233ffe6239c809a5e486f973e2dd25f25d818b4318630dc787a::vault::idle_usdc_value<T0>(arg0), 0x2::clock::timestamp_ms(arg2)));
    }

    // decompiled from Move bytecode v7
}

