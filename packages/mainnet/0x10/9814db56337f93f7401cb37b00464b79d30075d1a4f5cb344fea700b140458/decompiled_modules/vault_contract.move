module 0x109814db56337f93f7401cb37b00464b79d30075d1a4f5cb344fea700b140458::vault_contract {
    struct VaultShare has drop, store {
        id: 0x2::object::ID,
        amount: u64,
        owner: address,
    }

    struct DepositCertificate has drop, store {
        id: 0x2::object::ID,
        depositor: address,
        amount: u64,
    }

    struct Funding has drop, store {
        investor: address,
        amount: u64,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
        total_assets: u64,
        total_shares: u64,
        fundings: vector<Funding>,
        bluefin_pool_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct BluefinPosition has drop, store {
        id: 0x2::object::ID,
    }

    public entry fun create_bluefin_pool<T0>(arg0: &mut Vault, arg1: &0x2::clock::Clock, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u8, arg7: vector<u8>, arg8: vector<u8>, arg9: u8, arg10: vector<u8>, arg11: u32, arg12: u64, arg13: u128, arg14: u64, arg15: &mut 0x2::coin::TreasuryCap<0x2::sui::SUI>, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::create_pool_and_get_object<0x2::sui::SUI, T0, 0x2::sui::SUI>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.coin, arg14, arg16)), arg16);
        arg0.bluefin_pool_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>>(&v0));
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>>(v0, 0x2::tx_context::sender(arg16));
    }

    public entry fun deposit(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.coin, arg1);
        arg0.total_assets = arg0.total_assets + v0;
        arg0.total_shares = arg0.total_shares + v0;
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Funding>(&arg0.fundings)) {
            let v4 = 0x1::vector::borrow_mut<Funding>(&mut arg0.fundings, v3);
            if (v4.investor == v1) {
                v4.amount = v4.amount + v0;
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        if (!v2) {
            let v5 = Funding{
                investor : v1,
                amount   : v0,
            };
            0x1::vector::push_back<Funding>(&mut arg0.fundings, v5);
        };
        VaultShare{id: 0x2::object::id_from_address(0x2::tx_context::sender(arg2)), amount: v0, owner: v1};
        DepositCertificate{id: 0x2::object::id_from_address(0x2::tx_context::sender(arg2)), depositor: v1, amount: v0};
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id              : 0x2::object::new(arg0),
            coin            : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg0),
            total_assets    : 0,
            total_shares    : 0,
            fundings        : 0x1::vector::empty<Funding>(),
            bluefin_pool_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::public_share_object<Vault>(v0);
    }

    public entry fun open_bluefin_position<T0>(arg0: &mut Vault, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg2: u32, arg3: u32, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<0x2::sui::SUI, T0>(arg4, arg1, arg2, arg3, arg5), 0x2::tx_context::sender(arg5));
    }

    public entry fun withdraw(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<Funding>(&arg0.fundings)) {
            let v3 = 0x1::vector::borrow_mut<Funding>(&mut arg0.fundings, v1);
            if (v3.investor == v0) {
                assert!(v3.amount >= arg1, 0);
                v3.amount = v3.amount - arg1;
                v2 = true;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v2, 1);
        assert!(arg0.total_assets >= arg1, 2);
        arg0.total_assets = arg0.total_assets - arg1;
        arg0.total_shares = arg0.total_shares - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.coin, arg1, arg2), v0);
    }

    // decompiled from Move bytecode v6
}

