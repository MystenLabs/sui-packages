module 0xddeb4676e587420a92c2ff73e76a77dc92da6ad1f37158dc8e4d8faacf89dc2c::simple_dex_wrapper {
    struct SwapExecuted has copy, drop {
        dex: vector<u8>,
        pool_id: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        user: address,
    }

    struct DexWrapper has key {
        id: 0x2::object::UID,
        admin: address,
    }

    public entry fun cetus_sui_to_usdc(arg0: &DexWrapper, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = SwapExecuted{
            dex        : b"Cetus",
            pool_id    : arg1,
            amount_in  : v0,
            amount_out : arg3,
            user       : v1,
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1);
    }

    public entry fun cetus_usdc_to_sui<T0>(arg0: &DexWrapper, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = SwapExecuted{
            dex        : b"Cetus",
            pool_id    : arg1,
            amount_in  : v0,
            amount_out : arg3,
            user       : v1,
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
    }

    public entry fun create_wrapper(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DexWrapper{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<DexWrapper>(v0);
    }

    public entry fun deepbook_sui_to_usdc(arg0: &DexWrapper, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = SwapExecuted{
            dex        : b"DeepBook",
            pool_id    : arg1,
            amount_in  : v0,
            amount_out : arg3,
            user       : v1,
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1);
    }

    public entry fun execute_cetus_arbitrage(arg0: &DexWrapper, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = SwapExecuted{
            dex        : b"Cetus_Arbitrage",
            pool_id    : arg1,
            amount_in  : v0,
            amount_out : arg4,
            user       : v1,
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v1);
    }

    public fun get_admin(arg0: &DexWrapper) : address {
        arg0.admin
    }

    public entry fun turbos_sui_to_usdt(arg0: &DexWrapper, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(0x2::clock::timestamp_ms(arg5) < arg4, 2);
        let v2 = SwapExecuted{
            dex        : b"Turbos",
            pool_id    : arg1,
            amount_in  : v0,
            amount_out : arg3,
            user       : v1,
        };
        0x2::event::emit<SwapExecuted>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1);
    }

    public fun validate_pool_id(arg0: 0x2::object::ID) : bool {
        true
    }

    // decompiled from Move bytecode v6
}

