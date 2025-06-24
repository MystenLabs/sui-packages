module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_pool {
    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        decimal: u8,
    }

    struct DepositPool has copy, drop {
        pool: 0x1::ascii::String,
        sender: address,
        amount: u64,
    }

    struct WithdrawPool has copy, drop {
        pool: 0x1::ascii::String,
        receiver: address,
        amount: u64,
    }

    public fun convert_amount(arg0: u64, arg1: u8, arg2: u8) : u64 {
        while (arg1 != arg2) {
            if (arg1 < arg2) {
                arg0 = arg0 * 10;
                arg1 = arg1 + 1;
                continue
            };
            arg0 = arg0 / 10;
            arg1 = arg1 - 1;
        };
        arg0
    }

    public fun create_pool<T0>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
            decimal : 0x2::coin::get_decimals<T0>(arg0),
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public(friend) fun deposit<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u16, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v2 = DepositPool{
            pool   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sender : v0,
            amount : v1,
        };
        0x2::event::emit<DepositPool>(v2);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_codec::encode_deposit_payload(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_pool_to_dola<T0>(), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(v0), normal_amount<T0>(arg0, v1), arg2, arg3)
    }

    public fun get_coin_decimal<T0>(arg0: &Pool<T0>) : u8 {
        arg0.decimal
    }

    public fun normal_amount<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        convert_amount(arg1, get_coin_decimal<T0>(arg0), 8)
    }

    public(friend) fun send_message(arg0: u16, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : vector<u8> {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_codec::encode_send_message_payload(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(0x2::tx_context::sender(arg2)), arg0, arg1)
    }

    public fun unnormal_amount<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        convert_amount(arg1, 8, get_coin_decimal<T0>(arg0))
    }

    public(friend) fun withdraw<T0>(arg0: &mut Pool<T0>, arg1: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, arg2: u64, arg3: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id() == 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_chain_id(&arg3), 4);
        assert!(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&arg3) == 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())), 0);
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_dola_to_address(arg1);
        let v1 = unnormal_amount<T0>(arg0, arg2);
        let v2 = WithdrawPool{
            pool     : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            receiver : v0,
            amount   : v1,
        };
        0x2::event::emit<WithdrawPool>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v1), arg4), v0);
    }

    // decompiled from Move bytecode v6
}

