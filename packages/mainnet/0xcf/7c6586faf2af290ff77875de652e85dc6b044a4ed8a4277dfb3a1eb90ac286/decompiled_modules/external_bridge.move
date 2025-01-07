module 0xcf7c6586faf2af290ff77875de652e85dc6b044a4ed8a4277dfb3a1eb90ac286::external_bridge {
    struct IUSDCDeposited has copy, drop {
        tx_type: u8,
        partner_id: u128,
        amount: u64,
        dest_chain_id_bytes: vector<u8>,
        usdc_nonce: u64,
        token: 0x1::string::String,
        recipient: address,
        depositor: address,
        data: vector<u8>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PauseCap has store, key {
        id: 0x2::object::UID,
    }

    struct ResourceSetterCap has store, key {
        id: 0x2::object::UID,
    }

    struct DestDetail has drop, store {
        domain_id: u32,
        base_fee: u64,
        ata_creation_fee: u64,
    }

    struct ExternalBridge has key {
        id: 0x2::object::UID,
        initialized: bool,
        paused: bool,
        dst_details: 0x2::table::Table<vector<u8>, DestDetail>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun grant_role(arg0: &mut AdminCap, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            let v0 = AdminCap{id: 0x2::object::new(arg3)};
            0x2::transfer::public_transfer<AdminCap>(v0, arg2);
        } else if (arg1 == 1) {
            let v1 = ResourceSetterCap{id: 0x2::object::new(arg3)};
            0x2::transfer::public_transfer<ResourceSetterCap>(v1, arg2);
        } else {
            assert!(arg1 == 2, 3);
            let v2 = PauseCap{id: 0x2::object::new(arg3)};
            0x2::transfer::public_transfer<PauseCap>(v2, arg2);
        };
    }

    public entry fun i_deposit_usdc<T0: drop>(arg0: &mut ExternalBridge, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: u128, arg5: vector<u8>, arg6: address, arg7: vector<u8>, arg8: &0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::state::State, arg9: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg10: &0x2::deny_list::DenyList, arg11: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg12: &mut 0x2::tx_context::TxContext) : (0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::burn_message::BurnMessage, 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::Message) {
        when_not_paused(arg0);
        assert!(0x2::table::contains<vector<u8>, DestDetail>(&arg0.dst_details, arg5), 4);
        let v0 = 0x2::table::borrow<vector<u8>, DestDetail>(&arg0.dst_details, arg5);
        let v1 = v0.base_fee;
        let v2 = v1;
        if (arg3 > 1) {
            v2 = v1 + v0.ata_creation_fee;
        };
        assert!(v2 == 0 || 0x2::coin::value<0x2::sui::SUI>(&arg1) >= v2, 6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let (v3, v4) = 0x410d70c8baad60f310f45c13b9656ecbfed46fdf970e051f0cac42891a848856::deposit_for_burn::deposit_for_burn<T0>(arg2, v0.domain_id, arg6, arg8, arg9, arg10, arg11, arg12);
        let v5 = v4;
        let v6 = IUSDCDeposited{
            tx_type             : arg3,
            partner_id          : arg4,
            amount              : 0x2::coin::value<T0>(&arg2),
            dest_chain_id_bytes : arg5,
            usdc_nonce          : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::nonce(&v5),
            token               : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            recipient           : arg6,
            depositor           : 0x2::tx_context::sender(arg12),
            data                : arg7,
        };
        0x2::event::emit<IUSDCDeposited>(v6);
        (v3, v5)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ExternalBridge{
            id          : 0x2::object::new(arg0),
            initialized : true,
            paused      : false,
            dst_details : 0x2::table::new<vector<u8>, DestDetail>(arg0),
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = ResourceSetterCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ResourceSetterCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
        let v3 = PauseCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<PauseCap>(v3, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<ExternalBridge>(v0);
    }

    public entry fun pause(arg0: &mut ExternalBridge, arg1: &mut PauseCap, arg2: &0x2::tx_context::TxContext) {
        when_not_paused(arg0);
        arg0.paused = true;
    }

    public entry fun renounce_admin_cap(arg0: AdminCap, arg1: &0x2::tx_context::TxContext) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun renounce_pause_cap(arg0: PauseCap, arg1: &0x2::tx_context::TxContext) {
        let PauseCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun renounce_resource_setter_cap(arg0: ResourceSetterCap, arg1: &0x2::tx_context::TxContext) {
        let ResourceSetterCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun rescue_fee(arg0: &mut ExternalBridge, arg1: &mut AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2;
        if (arg2 == 0) {
            v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        };
        assert!(v0 > 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0), arg4), arg3);
    }

    public entry fun set_dest_details(arg0: &mut ExternalBridge, arg1: &mut ResourceSetterCap, arg2: vector<u8>, arg3: u32, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        if (0x2::table::contains<vector<u8>, DestDetail>(&arg0.dst_details, arg2)) {
            let v0 = 0x2::table::borrow_mut<vector<u8>, DestDetail>(&mut arg0.dst_details, arg2);
            v0.domain_id = arg3;
            v0.base_fee = arg4;
            v0.ata_creation_fee = arg5;
        } else {
            let v1 = DestDetail{
                domain_id        : arg3,
                base_fee         : arg4,
                ata_creation_fee : arg5,
            };
            0x2::table::add<vector<u8>, DestDetail>(&mut arg0.dst_details, arg2, v1);
        };
    }

    public entry fun unpause(arg0: &mut ExternalBridge, arg1: &mut PauseCap, arg2: &0x2::tx_context::TxContext) {
        when_paused(arg0);
        arg0.paused = false;
    }

    public entry fun unset_dest_details(arg0: &mut ExternalBridge, arg1: &mut ResourceSetterCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, DestDetail>(&arg0.dst_details, arg2), 4);
        0x2::table::remove<vector<u8>, DestDetail>(&mut arg0.dst_details, arg2);
    }

    fun when_not_paused(arg0: &ExternalBridge) {
        assert!(!arg0.paused, 1);
    }

    fun when_paused(arg0: &ExternalBridge) {
        assert!(arg0.paused, 2);
    }

    // decompiled from Move bytecode v6
}

