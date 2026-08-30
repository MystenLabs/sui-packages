module 0xfe47be69142372eacab34f66b936989079840501a0d85209ac68c8ba6f74eea5::ept_gateway {
    struct GatewayAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Gateway has key {
        id: 0x2::object::UID,
        sui_float: 0x2::balance::Balance<0x2::sui::SUI>,
        ept_type: 0x1::option::Option<0x1::type_name::TypeName>,
        ept_fee: u64,
        max_sui_fee: u64,
        paused: bool,
        vaults_created: u64,
        ept_burned: u64,
    }

    struct VaultPaidInEpt has copy, drop {
        payer: address,
        ept_burned: u64,
        sui_fee: u64,
        multi: bool,
    }

    struct ConfigUpdated has copy, drop {
        ept_type: 0x1::type_name::TypeName,
        ept_fee: u64,
    }

    struct FloatFunded has copy, drop {
        funder: address,
        amount: u64,
        new_total: u64,
    }

    struct FloatWithdrawn has copy, drop {
        amount: u64,
        new_total: u64,
    }

    struct MaxSuiFeeUpdated has copy, drop {
        max_sui_fee: u64,
    }

    struct PausedUpdated has copy, drop {
        paused: bool,
    }

    public fun create_multi_vault_with_ept<T0, T1>(arg0: &mut Gateway, arg1: &mut 0x848cb7edf8b5f7650b3188dec459394472c8ccf206a031497bf55fe40c165da2::vesting::Treasury, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T0>, arg4: vector<address>, arg5: vector<u64>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = take_and_burn_ept<T1>(arg0, arg2, arg11);
        let v1 = take_sui_fee(arg0, arg1, arg11);
        0x848cb7edf8b5f7650b3188dec459394472c8ccf206a031497bf55fe40c165da2::vesting::create_multi_vault<T0>(arg1, v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        arg0.vaults_created = arg0.vaults_created + 1;
        let v2 = VaultPaidInEpt{
            payer      : 0x2::tx_context::sender(arg11),
            ept_burned : v0,
            sui_fee    : 0x2::coin::value<0x2::sui::SUI>(&v1),
            multi      : true,
        };
        0x2::event::emit<VaultPaidInEpt>(v2);
    }

    public fun create_vault_with_ept<T0, T1>(arg0: &mut Gateway, arg1: &mut 0x848cb7edf8b5f7650b3188dec459394472c8ccf206a031497bf55fe40c165da2::vesting::Treasury, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T0>, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = take_and_burn_ept<T1>(arg0, arg2, arg10);
        let v1 = take_sui_fee(arg0, arg1, arg10);
        0x848cb7edf8b5f7650b3188dec459394472c8ccf206a031497bf55fe40c165da2::vesting::create_vault<T0>(arg1, v1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        arg0.vaults_created = arg0.vaults_created + 1;
        let v2 = VaultPaidInEpt{
            payer      : 0x2::tx_context::sender(arg10),
            ept_burned : v0,
            sui_fee    : 0x2::coin::value<0x2::sui::SUI>(&v1),
            multi      : false,
        };
        0x2::event::emit<VaultPaidInEpt>(v2);
    }

    public fun ept_burned(arg0: &Gateway) : u64 {
        arg0.ept_burned
    }

    public fun ept_fee(arg0: &Gateway) : u64 {
        arg0.ept_fee
    }

    public fun fund(arg0: &mut Gateway, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_float, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = FloatFunded{
            funder    : 0x2::tx_context::sender(arg2),
            amount    : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            new_total : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_float),
        };
        0x2::event::emit<FloatFunded>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Gateway{
            id             : 0x2::object::new(arg0),
            sui_float      : 0x2::balance::zero<0x2::sui::SUI>(),
            ept_type       : 0x1::option::none<0x1::type_name::TypeName>(),
            ept_fee        : 0,
            max_sui_fee    : 20000000000,
            paused         : false,
            vaults_created : 0,
            ept_burned     : 0,
        };
        0x2::transfer::share_object<Gateway>(v0);
        let v1 = GatewayAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<GatewayAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_configured(arg0: &Gateway) : bool {
        0x1::option::is_some<0x1::type_name::TypeName>(&arg0.ept_type)
    }

    public fun is_paused(arg0: &Gateway) : bool {
        arg0.paused
    }

    public fun max_sui_fee(arg0: &Gateway) : u64 {
        arg0.max_sui_fee
    }

    public fun set_ept_config<T0>(arg0: &GatewayAdminCap, arg1: &mut Gateway, arg2: u64) {
        assert!(arg2 > 0, 4);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        arg1.ept_type = 0x1::option::some<0x1::type_name::TypeName>(v0);
        arg1.ept_fee = arg2;
        let v1 = ConfigUpdated{
            ept_type : v0,
            ept_fee  : arg2,
        };
        0x2::event::emit<ConfigUpdated>(v1);
    }

    public fun set_max_sui_fee(arg0: &GatewayAdminCap, arg1: &mut Gateway, arg2: u64) {
        arg1.max_sui_fee = arg2;
        let v0 = MaxSuiFeeUpdated{max_sui_fee: arg2};
        0x2::event::emit<MaxSuiFeeUpdated>(v0);
    }

    public fun set_paused(arg0: &GatewayAdminCap, arg1: &mut Gateway, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PausedUpdated{paused: arg2};
        0x2::event::emit<PausedUpdated>(v0);
    }

    public fun sui_float(arg0: &Gateway) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_float)
    }

    fun take_and_burn_ept<T0>(arg0: &mut Gateway, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.paused, 6);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.ept_type), 0);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.ept_type) == 0x1::type_name::with_defining_ids<T0>(), 1);
        assert!(0x2::coin::value<T0>(&arg1) >= arg0.ept_fee, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, arg0.ept_fee, arg2), @0x0);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        arg0.ept_burned = arg0.ept_burned + arg0.ept_fee;
        arg0.ept_fee
    }

    fun take_sui_fee(arg0: &mut Gateway, arg1: &0x848cb7edf8b5f7650b3188dec459394472c8ccf206a031497bf55fe40c165da2::vesting::Treasury, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x848cb7edf8b5f7650b3188dec459394472c8ccf206a031497bf55fe40c165da2::vesting::deploy_fee(arg1);
        assert!(v0 <= arg0.max_sui_fee, 5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_float) >= v0, 3);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_float, v0, arg2)
    }

    public fun vaults_created(arg0: &Gateway) : u64 {
        arg0.vaults_created
    }

    public fun withdraw_sui(arg0: &GatewayAdminCap, arg1: &mut Gateway, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.sui_float, arg2, arg3), 0x2::tx_context::sender(arg3));
        let v0 = FloatWithdrawn{
            amount    : arg2,
            new_total : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_float),
        };
        0x2::event::emit<FloatWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

