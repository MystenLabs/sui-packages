module 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_treasury {
    struct VesselTreasury has key {
        id: 0x2::object::UID,
        vessel_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::test_usdc::TEST_USDC>,
        daily_spent: 0x2::table::Table<0x1::string::String, DailyBucket>,
    }

    struct DailyBucket has store {
        date_key: u64,
        spent: u64,
    }

    struct AgentCapability has store, key {
        id: 0x2::object::UID,
        treasury_id: 0x2::object::ID,
        per_tx_cap: u64,
        daily_cap: u64,
        whitelist: vector<address>,
        intent_tag: 0x1::string::String,
        expires_at_ms: u64,
        revoked: bool,
    }

    struct PaymentReceipt has store, key {
        id: 0x2::object::UID,
        treasury_id: 0x2::object::ID,
        agent_cap_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        intent_tag: 0x1::string::String,
        timestamp_ms: u64,
        walrus_cid: 0x1::option::Option<0x1::string::String>,
    }

    struct TreasuryFunded has copy, drop {
        treasury_id: 0x2::object::ID,
        amount: u64,
        funder: address,
    }

    struct CapabilityMinted has copy, drop {
        capability_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        intent_tag: 0x1::string::String,
        per_tx_cap: u64,
        daily_cap: u64,
    }

    struct CapabilityRevoked has copy, drop {
        capability_id: 0x2::object::ID,
    }

    struct CapabilityUpdated has copy, drop {
        capability_id: 0x2::object::ID,
        per_tx_cap: u64,
        daily_cap: u64,
    }

    struct PaymentExecuted has copy, drop {
        receipt_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        agent_cap_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        intent_tag: 0x1::string::String,
        timestamp_ms: u64,
    }

    public fun create_treasury(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg2: &mut 0x2::tx_context::TxContext) : VesselTreasury {
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::vessel_id_of_cap(arg0) == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 9);
        VesselTreasury{
            id          : 0x2::object::new(arg2),
            vessel_id   : 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1),
            balance     : 0x2::balance::zero<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::test_usdc::TEST_USDC>(),
            daily_spent : 0x2::table::new<0x1::string::String, DailyBucket>(arg2),
        }
    }

    public fun daily_spent_for_tag(arg0: &VesselTreasury, arg1: vector<u8>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::string::utf8(arg1);
        if (!0x2::table::contains<0x1::string::String, DailyBucket>(&arg0.daily_spent, v0)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x1::string::String, DailyBucket>(&arg0.daily_spent, v0);
        if (v1.date_key != 0x2::clock::timestamp_ms(arg2) / 86400000) {
            0
        } else {
            v1.spent
        }
    }

    public fun fund_treasury(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg1: &mut VesselTreasury, arg2: 0x2::coin::Coin<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::test_usdc::TEST_USDC>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::vessel_id_of_cap(arg0) == arg1.vessel_id, 9);
        0x2::balance::join<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::test_usdc::TEST_USDC>(&mut arg1.balance, 0x2::coin::into_balance<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::test_usdc::TEST_USDC>(arg2));
        let v0 = TreasuryFunded{
            treasury_id : 0x2::object::id<VesselTreasury>(arg1),
            amount      : 0x2::coin::value<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::test_usdc::TEST_USDC>(&arg2),
            funder      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TreasuryFunded>(v0);
    }

    public fun is_capability_active(arg0: &AgentCapability, arg1: &0x2::clock::Clock) : bool {
        !arg0.revoked && 0x2::clock::timestamp_ms(arg1) < arg0.expires_at_ms
    }

    public fun mint_agent_capability(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg1: &VesselTreasury, arg2: u64, arg3: u64, arg4: vector<address>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : AgentCapability {
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::vessel_id_of_cap(arg0) == arg1.vessel_id, 9);
        let v0 = AgentCapability{
            id            : 0x2::object::new(arg7),
            treasury_id   : 0x2::object::id<VesselTreasury>(arg1),
            per_tx_cap    : arg2,
            daily_cap     : arg3,
            whitelist     : arg4,
            intent_tag    : 0x1::string::utf8(arg5),
            expires_at_ms : arg6,
            revoked       : false,
        };
        let v1 = CapabilityMinted{
            capability_id : 0x2::object::id<AgentCapability>(&v0),
            treasury_id   : 0x2::object::id<VesselTreasury>(arg1),
            intent_tag    : v0.intent_tag,
            per_tx_cap    : arg2,
            daily_cap     : arg3,
        };
        0x2::event::emit<CapabilityMinted>(v1);
        v0
    }

    public fun receipt_agent_cap_id(arg0: &PaymentReceipt) : 0x2::object::ID {
        arg0.agent_cap_id
    }

    public fun receipt_amount(arg0: &PaymentReceipt) : u64 {
        arg0.amount
    }

    public fun receipt_intent_tag(arg0: &PaymentReceipt) : &0x1::string::String {
        &arg0.intent_tag
    }

    public fun receipt_recipient(arg0: &PaymentReceipt) : address {
        arg0.recipient
    }

    public fun receipt_timestamp_ms(arg0: &PaymentReceipt) : u64 {
        arg0.timestamp_ms
    }

    public fun receipt_treasury_id(arg0: &PaymentReceipt) : 0x2::object::ID {
        arg0.treasury_id
    }

    public fun receipt_walrus_cid(arg0: &PaymentReceipt) : &0x1::option::Option<0x1::string::String> {
        &arg0.walrus_cid
    }

    public fun revoke(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg1: &mut AgentCapability, arg2: &VesselTreasury) {
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::vessel_id_of_cap(arg0) == arg2.vessel_id, 9);
        assert!(arg1.treasury_id == 0x2::object::id<VesselTreasury>(arg2), 1);
        arg1.revoked = true;
        let v0 = CapabilityRevoked{capability_id: 0x2::object::id<AgentCapability>(arg1)};
        0x2::event::emit<CapabilityRevoked>(v0);
    }

    public fun set_walrus_cid_on_receipt(arg0: &mut PaymentReceipt, arg1: 0x1::string::String) {
        arg0.walrus_cid = 0x1::option::some<0x1::string::String>(arg1);
    }

    public fun share_treasury(arg0: VesselTreasury) {
        0x2::transfer::share_object<VesselTreasury>(arg0);
    }

    public fun treasury_balance(arg0: &VesselTreasury) : u64 {
        0x2::balance::value<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::test_usdc::TEST_USDC>(&arg0.balance)
    }

    public fun treasury_pay(arg0: &mut VesselTreasury, arg1: &AgentCapability, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : PaymentReceipt {
        assert!(arg1.treasury_id == 0x2::object::id<VesselTreasury>(arg0), 1);
        assert!(!arg1.revoked, 2);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 < arg1.expires_at_ms, 3);
        let v1 = 0x1::string::utf8(arg4);
        assert!(*0x1::string::as_bytes(&arg1.intent_tag) == *0x1::string::as_bytes(&v1), 4);
        assert!(0x1::vector::contains<address>(&arg1.whitelist, &arg2), 5);
        assert!(arg3 <= arg1.per_tx_cap, 6);
        let v2 = v0 / 86400000;
        if (0x2::table::contains<0x1::string::String, DailyBucket>(&arg0.daily_spent, v1)) {
            let v3 = 0x2::table::borrow_mut<0x1::string::String, DailyBucket>(&mut arg0.daily_spent, v1);
            if (v3.date_key != v2) {
                v3.date_key = v2;
                v3.spent = 0;
            };
            assert!(v3.spent + arg3 <= arg1.daily_cap, 7);
            v3.spent = v3.spent + arg3;
        } else {
            assert!(arg3 <= arg1.daily_cap, 7);
            let v4 = DailyBucket{
                date_key : v2,
                spent    : arg3,
            };
            0x2::table::add<0x1::string::String, DailyBucket>(&mut arg0.daily_spent, v1, v4);
        };
        assert!(0x2::balance::value<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::test_usdc::TEST_USDC>(&arg0.balance) >= arg3, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::test_usdc::TEST_USDC>>(0x2::coin::from_balance<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::test_usdc::TEST_USDC>(0x2::balance::split<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::test_usdc::TEST_USDC>(&mut arg0.balance, arg3), arg6), arg2);
        let v5 = PaymentReceipt{
            id           : 0x2::object::new(arg6),
            treasury_id  : 0x2::object::id<VesselTreasury>(arg0),
            agent_cap_id : 0x2::object::id<AgentCapability>(arg1),
            recipient    : arg2,
            amount       : arg3,
            intent_tag   : v1,
            timestamp_ms : v0,
            walrus_cid   : 0x1::option::none<0x1::string::String>(),
        };
        let v6 = PaymentExecuted{
            receipt_id   : 0x2::object::id<PaymentReceipt>(&v5),
            treasury_id  : 0x2::object::id<VesselTreasury>(arg0),
            agent_cap_id : 0x2::object::id<AgentCapability>(arg1),
            recipient    : arg2,
            amount       : arg3,
            intent_tag   : v1,
            timestamp_ms : v0,
        };
        0x2::event::emit<PaymentExecuted>(v6);
        v5
    }

    public fun treasury_vessel_id(arg0: &VesselTreasury) : 0x2::object::ID {
        arg0.vessel_id
    }

    public fun update_caps(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg1: &mut AgentCapability, arg2: &VesselTreasury, arg3: u64, arg4: u64) {
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::vessel_id_of_cap(arg0) == arg2.vessel_id, 9);
        assert!(arg1.treasury_id == 0x2::object::id<VesselTreasury>(arg2), 1);
        arg1.per_tx_cap = arg3;
        arg1.daily_cap = arg4;
        let v0 = CapabilityUpdated{
            capability_id : 0x2::object::id<AgentCapability>(arg1),
            per_tx_cap    : arg3,
            daily_cap     : arg4,
        };
        0x2::event::emit<CapabilityUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

