module 0xfc03879f2d0f697a8ad55a3b47a7cc69524613b9a4d61763256083e17a5b9d78::turbos_finance {
    struct FeeCollectedEvent has copy, drop {
        amount: u64,
        order_id: 0x1::string::String,
    }

    public entry fun pay_fee<T0>(arg0: &mut 0xfc03879f2d0f697a8ad55a3b47a7cc69524613b9a4d61763256083e17a5b9d78::fee::FeeObject, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 2);
        if (!0x2::dynamic_field::exists_<0x1::ascii::String>(0xfc03879f2d0f697a8ad55a3b47a7cc69524613b9a4d61763256083e17a5b9d78::fee::get_mut_fee_id(arg0), 0x1::type_name::get_address(&v0))) {
            0x2::dynamic_field::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(0xfc03879f2d0f697a8ad55a3b47a7cc69524613b9a4d61763256083e17a5b9d78::fee::get_mut_fee_id(arg0), 0x1::type_name::get_address(&v0), 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(0xfc03879f2d0f697a8ad55a3b47a7cc69524613b9a4d61763256083e17a5b9d78::fee::get_mut_fee_id(arg0), 0x1::type_name::get_address(&v0)), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg4)));
        0xfc03879f2d0f697a8ad55a3b47a7cc69524613b9a4d61763256083e17a5b9d78::utils::send_coin<T0>(arg1, 0x2::tx_context::sender(arg4));
        let v1 = FeeCollectedEvent{
            amount   : arg2,
            order_id : arg3,
        };
        0x2::event::emit<FeeCollectedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

