module 0xb39fb111cb86fce44bbb4fb82ccf520fe2f89aa8518b674c8b0408bbb24d1243::wallet {
    struct SharedWallet has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct WithdrawInfo has drop {
        amount: u64,
        sender: address,
        version: u64,
    }

    public fun donate<T0>(arg0: &mut SharedWallet, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>());
        if (0x2::dynamic_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            0x2::coin::put<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedWallet{
            id      : 0x2::object::new(arg0),
            version : 0,
        };
        0x2::transfer::share_object<SharedWallet>(v0);
    }

    public fun query<T0>(arg0: &SharedWallet) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>());
        if (0x2::dynamic_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public fun withdraw<T0>(arg0: &mut SharedWallet, arg1: u64, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>());
        let v1 = WithdrawInfo{
            amount  : arg1,
            sender  : 0x2::tx_context::sender(arg4),
            version : arg0.version,
        };
        let v2 = 0x2::bcs::to_bytes<WithdrawInfo>(&v1);
        let v3 = 0x2::hash::keccak256(&v2);
        let v4 = x"7e91307eecd2893f40fd56aacf13155837cd82e699acdb3f3af114c0f899ce8d";
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v4, &v3) == true, 1);
        let v5 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        let v6 = if (0x2::balance::value<T0>(v5) == arg1) {
            0x2::dynamic_field::remove<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)
        } else {
            0x2::balance::split<T0>(v5, arg1)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg4), 0x2::tx_context::sender(arg4));
        arg0.version = 0x2::clock::timestamp_ms(arg3);
    }

    // decompiled from Move bytecode v6
}

