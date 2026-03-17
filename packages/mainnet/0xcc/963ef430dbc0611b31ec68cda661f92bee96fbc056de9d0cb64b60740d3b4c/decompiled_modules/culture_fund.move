module 0xcc963ef430dbc0611b31ec68cda661f92bee96fbc056de9d0cb64b60740d3b4c::culture_fund {
    struct PlatformConfig has key {
        id: 0x2::object::UID,
        admin: address,
        fee_wallet: address,
        verified_handles: 0x2::table::Table<0x1::string::String, address>,
        pending_gifts: 0x2::table::Table<0x1::string::String, vector<0x2::object::ID>>,
    }

    struct Gift has store, key {
        id: 0x2::object::UID,
        depositor: address,
        recipient_handle: 0x1::string::String,
        recipient_wallet: 0x1::option::Option<address>,
        amount: u64,
        message: 0x1::string::String,
        created_at: u64,
        expires_at: u64,
        claimed: bool,
    }

    struct GiftDeposited has copy, drop {
        gift_id: 0x2::object::ID,
        depositor: address,
        recipient: 0x1::string::String,
        amount: u64,
        token_type: 0x1::string::String,
        message: 0x1::string::String,
        expires_at: u64,
    }

    struct GiftClaimed has copy, drop {
        gift_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        platform_fee: u64,
    }

    struct GiftExpired has copy, drop {
        gift_id: 0x2::object::ID,
        amount: u64,
    }

    struct HandleVerified has copy, drop {
        handle: 0x1::string::String,
        wallet: address,
    }

    public entry fun claim_by_wallet<T0>(arg0: &mut Gift, arg1: &mut PlatformConfig, arg2: &0x2::clock::Clock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.claimed, 1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 < arg0.expires_at, 2);
        let v0 = arg0.amount;
        let v1 = v0 * 200 / 10000;
        let v2 = v0 - v1;
        let v3 = 0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"balance");
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, v2), arg4), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg4), arg1.fee_wallet);
        arg0.claimed = true;
        arg0.recipient_wallet = 0x1::option::some<address>(arg3);
        let v4 = GiftClaimed{
            gift_id      : 0x2::object::id<Gift>(arg0),
            recipient    : arg3,
            amount       : v2,
            platform_fee : v1,
        };
        0x2::event::emit<GiftClaimed>(v4);
    }

    public entry fun deposit<T0>(arg0: &mut PlatformConfig, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 > 0, 0);
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v2 = v1 + 48 * 3600;
        let v3 = Gift{
            id               : 0x2::object::new(arg6),
            depositor        : 0x2::tx_context::sender(arg6),
            recipient_handle : arg2,
            recipient_wallet : 0x1::option::none<address>(),
            amount           : v0,
            message          : arg4,
            created_at       : v1,
            expires_at       : v2,
            claimed          : false,
        };
        0x2::dynamic_field::add<vector<u8>, 0x2::balance::Balance<T0>>(&mut v3.id, b"balance", 0x2::coin::into_balance<T0>(arg5));
        let v4 = GiftDeposited{
            gift_id    : 0x2::object::id<Gift>(&v3),
            depositor  : 0x2::tx_context::sender(arg6),
            recipient  : arg2,
            amount     : v0,
            token_type : arg3,
            message    : arg4,
            expires_at : v2,
        };
        0x2::event::emit<GiftDeposited>(v4);
        if (!0x2::table::contains<0x1::string::String, vector<0x2::object::ID>>(&arg0.pending_gifts, arg2)) {
            0x2::table::add<0x1::string::String, vector<0x2::object::ID>>(&mut arg0.pending_gifts, arg2, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x1::string::String, vector<0x2::object::ID>>(&mut arg0.pending_gifts, arg2), 0x2::object::id<Gift>(&v3));
        0x2::transfer::transfer<Gift>(v3, 0x2::tx_context::sender(arg6));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlatformConfig{
            id               : 0x2::object::new(arg0),
            admin            : 0x2::tx_context::sender(arg0),
            fee_wallet       : 0x2::tx_context::sender(arg0),
            verified_handles : 0x2::table::new<0x1::string::String, address>(arg0),
            pending_gifts    : 0x2::table::new<0x1::string::String, vector<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<PlatformConfig>(v0);
    }

    public fun is_expired(arg0: &Gift, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.expires_at
    }

    public entry fun process_expired<T0>(arg0: &mut Gift, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.expires_at, 2);
        assert!(!arg0.claimed, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::dynamic_field::remove<vector<u8>, 0x2::balance::Balance<T0>>(&mut arg0.id, b"balance"), arg2), arg0.depositor);
        arg0.claimed = true;
        let v0 = GiftExpired{
            gift_id : 0x2::object::id<Gift>(arg0),
            amount  : arg0.amount,
        };
        0x2::event::emit<GiftExpired>(v0);
    }

    public entry fun set_fee_wallet(arg0: &mut PlatformConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        arg0.fee_wallet = arg1;
    }

    public entry fun verify_handle(arg0: &mut PlatformConfig, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 0);
        0x2::table::add<0x1::string::String, address>(&mut arg0.verified_handles, arg1, arg2);
        let v0 = HandleVerified{
            handle : arg1,
            wallet : arg2,
        };
        0x2::event::emit<HandleVerified>(v0);
    }

    public entry fun verify_recipient<T0>(arg0: &mut Gift, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1, 0);
        assert!(!arg0.claimed, 1);
        arg0.recipient_wallet = 0x1::option::some<address>(arg1);
    }

    // decompiled from Move bytecode v6
}

