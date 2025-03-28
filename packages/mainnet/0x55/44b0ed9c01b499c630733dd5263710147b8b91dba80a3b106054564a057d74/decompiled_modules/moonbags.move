module 0xea1fbf611b77580c34832afb3c5dc54dfa0f57d61d8500515c17bcc809ae3156::moonbags {
    struct FeeCollectedEvent has copy, drop {
        amount: u64,
        order_id: 0x1::string::String,
    }

    public entry fun pay_fee<T0>(arg0: &mut 0xea1fbf611b77580c34832afb3c5dc54dfa0f57d61d8500515c17bcc809ae3156::fee::FeeObject, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 2);
        if (!0x2::dynamic_field::exists_<0x1::ascii::String>(0xea1fbf611b77580c34832afb3c5dc54dfa0f57d61d8500515c17bcc809ae3156::fee::get_mut_fee_id(arg0), 0x1::type_name::get_address(&v0))) {
            0x2::dynamic_field::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(0xea1fbf611b77580c34832afb3c5dc54dfa0f57d61d8500515c17bcc809ae3156::fee::get_mut_fee_id(arg0), 0x1::type_name::get_address(&v0), 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(0xea1fbf611b77580c34832afb3c5dc54dfa0f57d61d8500515c17bcc809ae3156::fee::get_mut_fee_id(arg0), 0x1::type_name::get_address(&v0)), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg4)));
        0xea1fbf611b77580c34832afb3c5dc54dfa0f57d61d8500515c17bcc809ae3156::utils::send_coin<T0>(arg1, 0x2::tx_context::sender(arg4));
        let v1 = FeeCollectedEvent{
            amount   : arg2,
            order_id : arg3,
        };
        0x2::event::emit<FeeCollectedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

