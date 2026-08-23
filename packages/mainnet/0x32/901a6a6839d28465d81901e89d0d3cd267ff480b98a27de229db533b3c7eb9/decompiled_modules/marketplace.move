module 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::marketplace {
    struct Marketplace has key {
        id: 0x2::object::UID,
        version: u64,
        fee_bps: u16,
        fee_recipient: address,
        paused: bool,
        allowed_coins: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        attestor_pubkey: vector<u8>,
        total_volume: u64,
        total_trades: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        marketplace_id: 0x2::object::ID,
    }

    struct CollectionConfigKey has copy, drop, store {
        collection: 0x1::type_name::TypeName,
    }

    struct CollectionConfig has store {
        fee_bps: 0x1::option::Option<u16>,
        verified: bool,
        blocked: bool,
    }

    struct Listed has copy, drop {
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        item_type: 0x1::string::String,
        seller: address,
        price: u64,
        coin_type: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct Delisted has copy, drop {
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        item_type: 0x1::string::String,
        seller: address,
        timestamp_ms: u64,
    }

    struct Traded has copy, drop {
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        item_type: 0x1::string::String,
        seller: address,
        buyer: address,
        price: u64,
        marketplace_fee: u64,
        coin_type: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct FeeConfigChanged has copy, drop {
        old_fee_bps: u16,
        new_fee_bps: u16,
        old_recipient: address,
        new_recipient: address,
    }

    struct PauseToggled has copy, drop {
        paused: bool,
    }

    struct CollectionConfigChanged has copy, drop {
        collection: 0x1::string::String,
        verified: bool,
        blocked: bool,
        fee_bps: 0x1::option::Option<u16>,
    }

    public fun delist<T0: store + key>(arg0: &Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        0x2::kiosk::delist<T0>(arg1, arg2, arg3);
        let v0 = Delisted{
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            item_id      : arg3,
            item_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            seller       : 0x2::tx_context::sender(arg5),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<Delisted>(v0);
    }

    public fun list<T0: store + key>(arg0: &Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: T0, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_price_in_bounds(arg4);
        assert_collection_tradable<T0>(arg0);
        0x2::kiosk::place_and_list<T0>(arg1, arg2, arg3, arg4);
        let v0 = Listed{
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            item_id      : 0x2::object::id<T0>(&arg3),
            item_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            seller       : 0x2::tx_context::sender(arg6),
            price        : arg4,
            coin_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::sui::SUI>())),
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<Listed>(v0);
    }

    public fun allow_coin<T0>(arg0: &mut Marketplace, arg1: &AdminCap) {
        assert_admin(arg0, arg1);
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_coins, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.allowed_coins, v0);
        };
    }

    fun assert_active(arg0: &Marketplace) {
        assert_version(arg0);
        assert!(!arg0.paused, 1);
    }

    fun assert_admin(arg0: &Marketplace, arg1: &AdminCap) {
        assert!(arg1.marketplace_id == 0x2::object::id<Marketplace>(arg0), 0);
    }

    fun assert_collection_tradable<T0>(arg0: &Marketplace) {
        let v0 = CollectionConfigKey{collection: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists<CollectionConfigKey>(&arg0.id, v0)) {
            assert!(!0x2::dynamic_field::borrow<CollectionConfigKey, CollectionConfig>(&arg0.id, v0).blocked, 5);
        };
    }

    fun assert_price_in_bounds(arg0: u64) {
        assert!(arg0 > 0, 3);
        assert!(arg0 >= 1000 && arg0 <= 1000000000000000000, 7);
    }

    fun assert_version(arg0: &Marketplace) {
        assert!(arg0.version == 1, 0);
    }

    public fun attestor_pubkey(arg0: &Marketplace) : vector<u8> {
        arg0.attestor_pubkey
    }

    public fun buy<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        assert_active(arg0);
        assert_collection_tradable<T0>(arg0);
        assert_price_in_bounds(arg3);
        let v0 = compute_fee<T0>(arg0, arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg4) >= arg3 + v0, 4);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg4, v0, arg6), arg0.fee_recipient);
        };
        let (v1, v2) = 0x2::kiosk::purchase<T0>(arg1, arg2, 0x2::coin::split<0x2::sui::SUI>(arg4, arg3, arg6));
        arg0.total_volume = arg0.total_volume + arg3;
        arg0.total_trades = arg0.total_trades + 1;
        let v3 = Traded{
            kiosk_id        : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            item_id         : arg2,
            item_type       : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            seller          : 0x2::kiosk::owner(arg1),
            buyer           : 0x2::tx_context::sender(arg6),
            price           : arg3,
            marketplace_fee : v0,
            coin_type       : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::sui::SUI>())),
            timestamp_ms    : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<Traded>(v3);
        (v1, v2)
    }

    public fun buy_and_confirm<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = buy<T0>(arg0, arg1, arg3, arg4, arg5, arg6, arg7);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg2, v1);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg7));
    }

    fun compute_fee<T0>(arg0: &Marketplace, arg1: u64) : u64 {
        let v0 = CollectionConfigKey{collection: 0x1::type_name::with_defining_ids<T0>()};
        let v1 = if (0x2::dynamic_field::exists<CollectionConfigKey>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_field::borrow<CollectionConfigKey, CollectionConfig>(&arg0.id, v0);
            if (0x1::option::is_some<u16>(&v2.fee_bps)) {
                *0x1::option::borrow<u16>(&v2.fee_bps)
            } else {
                arg0.fee_bps
            }
        } else {
            arg0.fee_bps
        };
        (((arg1 as u128) * (v1 as u128) / (10000 as u128)) as u64)
    }

    public fun disallow_coin<T0>(arg0: &mut Marketplace, arg1: &AdminCap) {
        assert_admin(arg0, arg1);
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_coins, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.allowed_coins, &v0);
        };
    }

    public fun fee_bps(arg0: &Marketplace) : u16 {
        arg0.fee_bps
    }

    public fun fee_recipient(arg0: &Marketplace) : address {
        arg0.fee_recipient
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id              : 0x2::object::new(arg0),
            version         : 1,
            fee_bps         : 200,
            fee_recipient   : 0x2::tx_context::sender(arg0),
            paused          : false,
            allowed_coins   : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            attestor_pubkey : b"",
            total_volume    : 0,
            total_trades    : 0,
        };
        let v1 = AdminCap{
            id             : 0x2::object::new(arg0),
            marketplace_id : 0x2::object::id<Marketplace>(&v0),
        };
        0x2::transfer::share_object<Marketplace>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_coin_allowed<T0>(arg0: &Marketplace) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::is_empty<0x1::type_name::TypeName>(&arg0.allowed_coins) || 0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed_coins, &v0)
    }

    public fun is_paused(arg0: &Marketplace) : bool {
        arg0.paused
    }

    public fun list_existing<T0: store + key>(arg0: &Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_price_in_bounds(arg4);
        assert_collection_tradable<T0>(arg0);
        0x2::kiosk::list<T0>(arg1, arg2, arg3, arg4);
        let v0 = Listed{
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            item_id      : arg3,
            item_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            seller       : 0x2::tx_context::sender(arg6),
            price        : arg4,
            coin_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::sui::SUI>())),
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<Listed>(v0);
    }

    public fun migrate(arg0: &mut Marketplace, arg1: &AdminCap) {
        assert_admin(arg0, arg1);
        assert!(arg0.version < 1, 6);
        arg0.version = 1;
    }

    public fun quote<T0>(arg0: &Marketplace, arg1: u64) : (u64, u64) {
        let v0 = compute_fee<T0>(arg0, arg1);
        (v0, arg1 + v0)
    }

    public(friend) fun record_trade(arg0: &mut Marketplace, arg1: u64) {
        arg0.total_volume = arg0.total_volume + arg1;
        arg0.total_trades = arg0.total_trades + 1;
    }

    public fun reprice<T0: store + key>(arg0: &Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert_price_in_bounds(arg4);
        0x2::kiosk::delist<T0>(arg1, arg2, arg3);
        0x2::kiosk::list<T0>(arg1, arg2, arg3, arg4);
        let v0 = Listed{
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            item_id      : arg3,
            item_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            seller       : 0x2::tx_context::sender(arg6),
            price        : arg4,
            coin_type    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::sui::SUI>())),
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<Listed>(v0);
    }

    public fun set_attestor_pubkey(arg0: &mut Marketplace, arg1: &AdminCap, arg2: vector<u8>) {
        assert_admin(arg0, arg1);
        assert_version(arg0);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 8);
        arg0.attestor_pubkey = arg2;
    }

    public fun set_collection_config<T0>(arg0: &mut Marketplace, arg1: &AdminCap, arg2: bool, arg3: bool, arg4: 0x1::option::Option<u16>) {
        assert_admin(arg0, arg1);
        assert_version(arg0);
        if (0x1::option::is_some<u16>(&arg4)) {
            assert!(*0x1::option::borrow<u16>(&arg4) <= 1000, 2);
        };
        let v0 = CollectionConfigKey{collection: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists<CollectionConfigKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<CollectionConfigKey, CollectionConfig>(&mut arg0.id, v0);
            v1.verified = arg2;
            v1.blocked = arg3;
            v1.fee_bps = arg4;
        } else {
            let v2 = CollectionConfig{
                fee_bps  : arg4,
                verified : arg2,
                blocked  : arg3,
            };
            0x2::dynamic_field::add<CollectionConfigKey, CollectionConfig>(&mut arg0.id, v0, v2);
        };
        let v3 = CollectionConfigChanged{
            collection : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())),
            verified   : arg2,
            blocked    : arg3,
            fee_bps    : arg4,
        };
        0x2::event::emit<CollectionConfigChanged>(v3);
    }

    public fun set_fee(arg0: &mut Marketplace, arg1: &AdminCap, arg2: u16, arg3: address) {
        assert_admin(arg0, arg1);
        assert_version(arg0);
        assert!(arg2 <= 1000, 2);
        assert!(arg3 != @0x0, 8);
        let v0 = FeeConfigChanged{
            old_fee_bps   : arg0.fee_bps,
            new_fee_bps   : arg2,
            old_recipient : arg0.fee_recipient,
            new_recipient : arg3,
        };
        0x2::event::emit<FeeConfigChanged>(v0);
        arg0.fee_bps = arg2;
        arg0.fee_recipient = arg3;
    }

    public fun set_paused(arg0: &mut Marketplace, arg1: &AdminCap, arg2: bool) {
        assert_admin(arg0, arg1);
        assert_version(arg0);
        arg0.paused = arg2;
        let v0 = PauseToggled{paused: arg2};
        0x2::event::emit<PauseToggled>(v0);
    }

    public fun total_trades(arg0: &Marketplace) : u64 {
        arg0.total_trades
    }

    public fun total_volume(arg0: &Marketplace) : u64 {
        arg0.total_volume
    }

    public fun version(arg0: &Marketplace) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

