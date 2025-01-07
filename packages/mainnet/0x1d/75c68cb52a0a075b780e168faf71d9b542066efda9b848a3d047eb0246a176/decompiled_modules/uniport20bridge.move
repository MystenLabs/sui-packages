module 0x1d75c68cb52a0a075b780e168faf71d9b542066efda9b848a3d047eb0246a176::uniport20bridge {
    struct UNIPORT20BRIDGE has drop {
        dummy_field: bool,
    }

    struct BridgeAdminCap has key {
        id: 0x2::object::UID,
    }

    struct MultiSigAdminCap has key {
        id: 0x2::object::UID,
    }

    struct UniPort20<phantom T0> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<UniPort20<T0>>,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
    }

    struct BridgeState has key {
        id: 0x2::object::UID,
        feeManager: 0x1::option::Option<address>,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        chainFees: 0x2::table::Table<u128, u64>,
        supportChains: 0x2::table::Table<u128, bool>,
        used: 0x2::table::Table<0x1::string::String, bool>,
        symbolContracts: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
    }

    struct FeeManagerChanged has copy, drop {
        oldFeeManager: address,
        newFeeManager: address,
    }

    struct FeeChanged has copy, drop {
        chainId: u128,
        oldFee: u64,
        newFee: u64,
    }

    struct SupportChainsChanged has copy, drop {
        chainId: u128,
        preSupport: bool,
        support: bool,
    }

    struct UNIPORT20Created has copy, drop {
        sender: address,
        uniport20: 0x1::string::String,
        symbol: 0x1::string::String,
    }

    struct BridgeMinted has copy, drop {
        token: 0x1::string::String,
        to: address,
        amount: u64,
        srcChainId: u128,
        txId: 0x1::string::String,
    }

    struct BridgeBurned has copy, drop {
        token: 0x1::string::String,
        from: address,
        amount: u64,
        chainId: u128,
        fee: u64,
        receiver: 0x1::string::String,
    }

    public entry fun transfer(arg0: BridgeAdminCap, arg1: address) {
        0x2::transfer::transfer<BridgeAdminCap>(arg0, arg1);
    }

    public entry fun burn<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2::coin::Coin<UniPort20<T0>>, arg2: &mut BridgeState, arg3: u64, arg4: u128, arg5: vector<u8>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 1);
        assert!(arg3 <= 0x2::coin::value<UniPort20<T0>>(arg1), 6);
        assert!(0x2::table::contains<u128, bool>(&arg2.supportChains, arg4), 2);
        assert!(0x2::table::contains<u128, u64>(&arg2.chainFees, arg4), 3);
        let v0 = *0x2::table::borrow<u128, u64>(&arg2.chainFees, arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg6) >= v0, 5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.sui, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg6, v0, arg7)));
        0x2::balance::decrease_supply<UniPort20<T0>>(&mut arg0.supply, 0x2::coin::into_balance<UniPort20<T0>>(0x2::coin::split<UniPort20<T0>>(arg1, arg3, arg7)));
        let v1 = BridgeBurned{
            token    : type_of<UniPort20<T0>>(),
            from     : 0x2::tx_context::sender(arg7),
            amount   : arg3,
            chainId  : arg4,
            fee      : v0,
            receiver : 0x1::string::utf8(arg5),
        };
        0x2::event::emit<BridgeBurned>(v1);
    }

    public entry fun createUNIPORT20<T0: drop>(arg0: T0, arg1: &mut BridgeState, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: &BridgeAdminCap, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = UniPort20<T0>{dummy_field: false};
        let v1 = 0x1::string::utf8(arg3);
        assert!(!0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg1.symbolContracts, v1), 8);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg1.symbolContracts, v1, type_of<UniPort20<T0>>());
        let v2 = Pool<T0>{
            id       : 0x2::object::new(arg6),
            supply   : 0x2::balance::create_supply<UniPort20<T0>>(v0),
            name     : 0x1::string::utf8(arg2),
            symbol   : v1,
            decimals : arg4,
        };
        0x2::transfer::share_object<Pool<T0>>(v2);
        let v3 = UNIPORT20Created{
            sender    : 0x2::tx_context::sender(arg6),
            uniport20 : type_of<UniPort20<T0>>(),
            symbol    : v1,
        };
        0x2::event::emit<UNIPORT20Created>(v3);
    }

    fun init(arg0: UNIPORT20BRIDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeState{
            id              : 0x2::object::new(arg1),
            feeManager      : 0x1::option::none<address>(),
            sui             : 0x2::balance::zero<0x2::sui::SUI>(),
            chainFees       : 0x2::table::new<u128, u64>(arg1),
            supportChains   : 0x2::table::new<u128, bool>(arg1),
            used            : 0x2::table::new<0x1::string::String, bool>(arg1),
            symbolContracts : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg1),
        };
        0x2::transfer::share_object<BridgeState>(v0);
        let v1 = BridgeAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BridgeAdminCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = MultiSigAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MultiSigAdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint<T0>(arg0: &mut Pool<T0>, arg1: &mut BridgeState, arg2: address, arg3: u64, arg4: u128, arg5: vector<u8>, arg6: &MultiSigAdminCap, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<UniPort20<T0>>>(mint_<T0>(arg0, arg1, arg3, arg4, 0x1::string::utf8(arg5), arg7), arg2);
        let v0 = BridgeMinted{
            token      : type_of<UniPort20<T0>>(),
            to         : arg2,
            amount     : arg3,
            srcChainId : arg4,
            txId       : 0x1::string::utf8(arg5),
        };
        0x2::event::emit<BridgeMinted>(v0);
    }

    fun mint_<T0>(arg0: &mut Pool<T0>, arg1: &mut BridgeState, arg2: u64, arg3: u128, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<UniPort20<T0>> {
        assert!(0x2::table::contains<u128, bool>(&arg1.supportChains, arg3), 2);
        assert!(0x2::table::contains<u128, u64>(&arg1.chainFees, arg3), 3);
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg1.used, arg4), 4);
        0x2::table::add<0x1::string::String, bool>(&mut arg1.used, arg4, true);
        0x2::coin::from_balance<UniPort20<T0>>(0x2::balance::increase_supply<UniPort20<T0>>(&mut arg0.supply, arg2), arg5)
    }

    public entry fun setFee(arg0: &mut BridgeState, arg1: u128, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(*0x1::option::borrow<address>(&arg0.feeManager) == 0x2::tx_context::sender(arg3), 7);
        if (0x2::table::contains<u128, u64>(&arg0.chainFees, arg1)) {
            let v0 = FeeChanged{
                chainId : arg1,
                oldFee  : *0x2::table::borrow<u128, u64>(&arg0.chainFees, arg1),
                newFee  : arg2,
            };
            0x2::event::emit<FeeChanged>(v0);
            *0x2::table::borrow_mut<u128, u64>(&mut arg0.chainFees, arg1) = arg2;
        } else {
            0x2::table::add<u128, u64>(&mut arg0.chainFees, arg1, arg2);
            let v1 = FeeChanged{
                chainId : arg1,
                oldFee  : 0,
                newFee  : arg2,
            };
            0x2::event::emit<FeeChanged>(v1);
        };
    }

    public entry fun setFeeManager(arg0: &mut BridgeState, arg1: address, arg2: &BridgeAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::swap_or_fill<address>(&mut arg0.feeManager, arg1);
        if (0x1::option::is_some<address>(&v0)) {
            let v1 = FeeManagerChanged{
                oldFeeManager : 0x1::option::destroy_some<address>(v0),
                newFeeManager : arg1,
            };
            0x2::event::emit<FeeManagerChanged>(v1);
        } else {
            let v2 = FeeManagerChanged{
                oldFeeManager : @0x0,
                newFeeManager : arg1,
            };
            0x2::event::emit<FeeManagerChanged>(v2);
        };
    }

    public entry fun setSupportChains(arg0: &mut BridgeState, arg1: u128, arg2: bool, arg3: &BridgeAdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<u128, bool>(&arg0.supportChains, arg1)) {
            let v0 = SupportChainsChanged{
                chainId    : arg1,
                preSupport : *0x2::table::borrow<u128, bool>(&arg0.supportChains, arg1),
                support    : arg2,
            };
            0x2::event::emit<SupportChainsChanged>(v0);
            *0x2::table::borrow_mut<u128, bool>(&mut arg0.supportChains, arg1) = arg2;
        } else {
            0x2::table::add<u128, bool>(&mut arg0.supportChains, arg1, arg2);
            let v1 = SupportChainsChanged{
                chainId    : arg1,
                preSupport : false,
                support    : arg2,
            };
            0x2::event::emit<SupportChainsChanged>(v1);
        };
    }

    public entry fun transfer_msign(arg0: MultiSigAdminCap, arg1: address) {
        0x2::transfer::transfer<MultiSigAdminCap>(arg0, arg1);
    }

    public fun type_of<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public entry fun withdraw(arg0: &mut BridgeState, arg1: address, arg2: &BridgeAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::sui::transfer(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui), arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

