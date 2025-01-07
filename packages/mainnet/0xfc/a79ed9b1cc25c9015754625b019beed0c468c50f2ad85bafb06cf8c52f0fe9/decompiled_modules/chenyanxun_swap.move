module 0xfca79ed9b1cc25c9015754625b019beed0c468c50f2ad85bafb06cf8c52f0fe9::chenyanxun_swap {
    struct Bank has key {
        id: 0x2::object::UID,
        my_coin_balance: 0x2::balance::Balance<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>,
        share_coin_balance: 0x2::balance::Balance<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>,
        rate: u8,
        fee: u64,
    }

    struct Result has copy, drop {
        user: address,
        from_coin: 0x1::string::String,
        to_coin: 0x1::string::String,
        amount: u64,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_mycoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>(arg1);
        0x2::balance::join<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>(&mut arg0.my_coin_balance, 0x2::balance::split<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>(&mut v0, arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>>(0x2::coin::from_balance<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>(v0, arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id                 : 0x2::object::new(arg0),
            my_coin_balance    : 0x2::balance::zero<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>(),
            share_coin_balance : 0x2::balance::zero<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>(),
            rate               : 2,
            fee                : 1,
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun mycoin_swap_sharecoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>(&arg1) >= arg2 + 1, 1);
        assert!(0x2::balance::value<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>(&arg0.share_coin_balance) >= arg2 * 2, 2);
        let v0 = 0x2::coin::into_balance<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>(arg1);
        0x2::balance::join<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>(&mut arg0.my_coin_balance, 0x2::balance::split<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>(&mut v0, arg2 + 1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>>(0x2::coin::from_balance<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>(v0, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>>(0x2::coin::take<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>(&mut arg0.share_coin_balance, arg2 * 2, arg3), 0x2::tx_context::sender(arg3));
        let v1 = Result{
            user      : 0x2::tx_context::sender(arg3),
            from_coin : 0x1::string::utf8(b"MY_COIN"),
            to_coin   : 0x1::string::utf8(b"SHARE_COIN"),
            amount    : arg2,
        };
        0x2::event::emit<Result>(v1);
    }

    public entry fun sharecoin_swap_mycoin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>(&arg1) > arg2 + 2, 1);
        assert!(0x2::balance::value<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>(&arg0.my_coin_balance) >= arg2 / 2, 2);
        let v0 = 0x2::coin::into_balance<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>(arg1);
        0x2::balance::join<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>(&mut arg0.share_coin_balance, 0x2::balance::split<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>(&mut v0, arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>>(0x2::coin::from_balance<0xaf670ea2220ea05286d87724392a8b848f9cf6e42bf61a28f957ecffda8f253e::share_coin::SHARE_COIN>(v0, arg3), 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>>(0x2::coin::take<0x1a85ad3480a87e3b8f5c5cecb3d3d2c6917c484d2ee8ba61c246c8f14810143d::my_coin::MY_COIN>(&mut arg0.my_coin_balance, arg2 * 2, arg3), 0x2::tx_context::sender(arg3));
        let v1 = Result{
            user      : 0x2::tx_context::sender(arg3),
            from_coin : 0x1::string::utf8(b"SHARE_COIN"),
            to_coin   : 0x1::string::utf8(b"MY_COIN"),
            amount    : arg2,
        };
        0x2::event::emit<Result>(v1);
    }

    // decompiled from Move bytecode v6
}

