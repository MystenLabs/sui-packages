module 0xcb03101bb6f75ab6a3d9fdb94edab3fd1b88f24b4cb768e262b791001e7843bb::rollup_news_claim {
    struct ClaimCreatedEvent has copy, drop {
        claim_id: 0x2::object::ID,
        recipient: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        data: 0x1::string::String,
    }

    struct MasterPower has key {
        id: 0x2::object::UID,
    }

    struct UpgradeControl has key {
        id: 0x2::object::UID,
        is_v2_initialized: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        minting_limit: 0x2::table::Table<address, u64>,
        last_minting_period_ms: u64,
    }

    struct Treasury_v2 has key {
        id: 0x2::object::UID,
        wallets: 0x2::object_table::ObjectTable<address, Wallet>,
    }

    struct Claim has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        data: 0x1::string::String,
    }

    struct Wallet has store, key {
        id: 0x2::object::UID,
        minting_limit: u64,
        last_minting_period_ms: u64,
    }

    public entry fun create_claim(arg0: &0x2::clock::Clock, arg1: &mut Treasury, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (v0 >= arg1.last_minting_period_ms + 86400000) {
            int_set_minting_limit(arg1, arg2, 50);
            arg1.last_minting_period_ms = v0;
        } else if (!0x2::table::contains<address, u64>(&arg1.minting_limit, arg2)) {
            int_set_minting_limit(arg1, arg2, 50);
        };
        assert!(int_get_minting_limit(arg1, arg2) > 0, 1);
        int_decrement_minting_limit(arg1, arg2);
        let v1 = 0x2::url::new_unsafe_from_bytes(arg5);
        let v2 = Claim{
            id          : 0x2::object::new(arg7),
            name        : arg3,
            description : arg4,
            url         : v1,
            data        : arg6,
        };
        let v3 = ClaimCreatedEvent{
            claim_id    : 0x2::object::id<Claim>(&v2),
            recipient   : arg2,
            name        : arg3,
            description : arg4,
            url         : v1,
            data        : arg6,
        };
        0x2::event::emit<ClaimCreatedEvent>(v3);
        0x2::transfer::public_transfer<Claim>(v2, arg2);
    }

    public entry fun create_claim_v2(arg0: &0x2::clock::Clock, arg1: &mut Treasury_v2, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (!0x2::object_table::contains<address, Wallet>(&arg1.wallets, arg2)) {
            let v1 = Wallet{
                id                     : 0x2::object::new(arg7),
                minting_limit          : 50,
                last_minting_period_ms : v0,
            };
            0x2::object_table::add<address, Wallet>(&mut arg1.wallets, arg2, v1);
        } else {
            let v2 = 0x2::object_table::borrow_mut<address, Wallet>(&mut arg1.wallets, arg2);
            if (v0 >= v2.last_minting_period_ms + 86400000) {
                v2.minting_limit = 50;
                v2.last_minting_period_ms = v0;
            };
        };
        let v3 = 0x2::object_table::borrow_mut<address, Wallet>(&mut arg1.wallets, arg2);
        assert!(v3.minting_limit > 0, 1);
        v3.minting_limit = v3.minting_limit - 1;
        let v4 = 0x2::url::new_unsafe_from_bytes(arg5);
        let v5 = Claim{
            id          : 0x2::object::new(arg7),
            name        : arg3,
            description : arg4,
            url         : v4,
            data        : arg6,
        };
        let v6 = ClaimCreatedEvent{
            claim_id    : 0x2::object::id<Claim>(&v5),
            recipient   : arg2,
            name        : arg3,
            description : arg4,
            url         : v4,
            data        : arg6,
        };
        0x2::event::emit<ClaimCreatedEvent>(v6);
        0x2::transfer::public_transfer<Claim>(v5, arg2);
    }

    public entry fun create_upgrade_control(arg0: &MasterPower, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = UpgradeControl{
            id                : 0x2::object::new(arg1),
            is_v2_initialized : false,
        };
        0x2::transfer::share_object<UpgradeControl>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MasterPower{id: 0x2::object::new(arg0)};
        let v1 = Treasury{
            id                     : 0x2::object::new(arg0),
            minting_limit          : 0x2::table::new<address, u64>(arg0),
            last_minting_period_ms : 0,
        };
        0x2::transfer::share_object<Treasury>(v1);
        0x2::transfer::transfer<MasterPower>(v0, @0xa2668b3f6ed6c95ccacd471cb1f4351b9ae4b11d865c45a764332cbcafc6b3f3);
    }

    public entry fun init_v2(arg0: &mut MasterPower, arg1: &mut UpgradeControl, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_v2_initialized == false, 2);
        arg1.is_v2_initialized = true;
        let v0 = Treasury_v2{
            id      : 0x2::object::new(arg2),
            wallets : 0x2::object_table::new<address, Wallet>(arg2),
        };
        0x2::transfer::share_object<Treasury_v2>(v0);
    }

    fun int_decrement_minting_limit(arg0: &mut Treasury, arg1: address) : bool {
        if (!0x2::table::contains<address, u64>(&arg0.minting_limit, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.minting_limit, arg1);
        if (*v0 == 0) {
            return false
        };
        *v0 = *v0 - 1;
        true
    }

    fun int_get_minting_limit(arg0: &Treasury, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.minting_limit, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.minting_limit, arg1)
        } else {
            0
        }
    }

    fun int_set_minting_limit(arg0: &mut Treasury, arg1: address, arg2: u64) {
        assert!(arg2 <= 50, 0);
        if (0x2::table::contains<address, u64>(&arg0.minting_limit, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.minting_limit, arg1) = arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.minting_limit, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

