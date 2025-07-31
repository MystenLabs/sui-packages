module 0x1bb9a91e0d2ee17473649713aa4e4dbd20e6ed36e7d5be584cc066b1a7fcf4f5::passkey_wallet {
    struct PasskeyAuthenticator has copy, drop {
        authenticator_data: vector<u8>,
        client_data_json: vector<u8>,
        user_signature: vector<u8>,
    }

    struct SmartWallet has store, key {
        id: 0x2::object::UID,
        owner_public_key: vector<u8>,
        admin: address,
        executor: address,
    }

    public fun change_executor(arg0: &mut SmartWallet, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        arg0.executor = arg1;
    }

    public fun create_wallet(arg0: vector<u8>, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : SmartWallet {
        SmartWallet{
            id               : 0x2::object::new(arg3),
            owner_public_key : arg0,
            admin            : arg1,
            executor         : arg2,
        }
    }

    public fun deposit<T0>(arg0: &mut SmartWallet, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun get_admin_address(arg0: &SmartWallet) : address {
        arg0.admin
    }

    public fun get_balance<T0>(arg0: &SmartWallet) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0))
        } else {
            0
        }
    }

    public fun get_executor_address(arg0: &SmartWallet) : address {
        arg0.executor
    }

    public fun has_coin_type<T0>(arg0: &SmartWallet) : bool {
        0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())
    }

    public fun transfer_by_executor<T0>(arg0: &mut SmartWallet, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.executor, 7);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 8);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg3), arg2);
        if (0x2::balance::value<T0>(v1) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0));
        };
    }

    // decompiled from Move bytecode v6
}

