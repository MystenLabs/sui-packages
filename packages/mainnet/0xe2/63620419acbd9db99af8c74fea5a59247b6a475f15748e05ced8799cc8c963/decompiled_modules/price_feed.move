module 0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::price_feed {
    struct PriceValue has copy, drop, store {
        mantissa: u64,
        negative: bool,
        expo: u64,
        expo_negative: bool,
        conf: u64,
        publish_time_ms: u64,
    }

    struct ReferencePrice has copy, drop, store {
        price: PriceValue,
        trusted_pubkey: vector<u8>,
        max_deviation_bps: u64,
        max_reference_staleness_ms: u64,
        last_reference_signer_rotation_ms: u64,
        pending_reference_signer_rotation: 0x1::option::Option<PendingRotation>,
    }

    struct PriceFeed has key {
        id: 0x2::object::UID,
        symbol: vector<u8>,
        price: PriceValue,
        trusted_pubkey: vector<u8>,
        reference: 0x1::option::Option<ReferencePrice>,
        ema: 0x1::option::Option<PriceValue>,
        version: u64,
        last_signer_rotation_ms: u64,
        retired: bool,
        pending_signer_rotation: 0x1::option::Option<PendingRotation>,
        publish_fee: u64,
        fee_recipient: address,
    }

    struct PriceFeedCreated has copy, drop {
        feed_id: 0x2::object::ID,
        symbol: vector<u8>,
    }

    struct FeedRetired has copy, drop {
        feed_id: 0x2::object::ID,
        symbol: vector<u8>,
    }

    struct PricePosted has copy, drop {
        feed_id: 0x2::object::ID,
        mantissa: u64,
        negative: bool,
        expo: u64,
        expo_negative: bool,
        conf: u64,
        publish_time_ms: u64,
        has_ema: bool,
        ema_mantissa: u64,
        ema_negative: bool,
        ema_expo: u64,
        ema_expo_negative: bool,
        ema_conf: u64,
        ema_publish_time_ms: u64,
    }

    struct PricePayload has drop {
        symbol: vector<u8>,
        mantissa: u64,
        negative: bool,
        expo: u64,
        expo_negative: bool,
        conf: u64,
        publish_time_ms: u64,
        has_ema: bool,
        ema_mantissa: u64,
        ema_negative: bool,
        ema_expo: u64,
        ema_expo_negative: bool,
        ema_conf: u64,
        ema_publish_time_ms: u64,
        feed_id: 0x2::object::ID,
        domain: vector<u8>,
    }

    struct SignerRotated has copy, drop {
        feed_id: 0x2::object::ID,
        new_pubkey: vector<u8>,
    }

    struct ReferenceSignerRotated has copy, drop {
        feed_id: 0x2::object::ID,
        new_pubkey: vector<u8>,
    }

    struct PendingRotation has copy, drop, store {
        new_pubkey: vector<u8>,
        requested_at_ms: u64,
        requested_by_cap_id: 0x2::object::ID,
    }

    struct SignerRotationRequested has copy, drop {
        feed_id: 0x2::object::ID,
        new_pubkey: vector<u8>,
        requested_at_ms: u64,
        requested_by_cap_id: 0x2::object::ID,
    }

    struct SignerRotationCancelled has copy, drop {
        feed_id: 0x2::object::ID,
        new_pubkey: vector<u8>,
    }

    struct ReferenceSignerRotationRequested has copy, drop {
        feed_id: 0x2::object::ID,
        new_pubkey: vector<u8>,
        requested_at_ms: u64,
        requested_by_cap_id: 0x2::object::ID,
    }

    struct ReferenceSignerRotationCancelled has copy, drop {
        feed_id: 0x2::object::ID,
        new_pubkey: vector<u8>,
    }

    struct ReferenceToleranceUpdated has copy, drop {
        feed_id: 0x2::object::ID,
        old_max_deviation_bps: u64,
        new_max_deviation_bps: u64,
        old_max_reference_staleness_ms: u64,
        new_max_reference_staleness_ms: u64,
    }

    struct ReferenceAttached has copy, drop {
        feed_id: 0x2::object::ID,
    }

    struct PublishFeeUpdated has copy, drop {
        feed_id: 0x2::object::ID,
        old_publish_fee: u64,
        new_publish_fee: u64,
        old_fee_recipient: address,
        new_fee_recipient: address,
    }

    struct ReferencePosted has copy, drop {
        feed_id: 0x2::object::ID,
        mantissa: u64,
        negative: bool,
        expo: u64,
        expo_negative: bool,
        conf: u64,
        publish_time_ms: u64,
        max_deviation_bps: u64,
        max_reference_staleness_ms: u64,
    }

    struct ReferencePricePayload has drop {
        symbol: vector<u8>,
        mantissa: u64,
        negative: bool,
        expo: u64,
        expo_negative: bool,
        conf: u64,
        publish_time_ms: u64,
        max_deviation_bps: u64,
        max_reference_staleness_ms: u64,
        feed_id: 0x2::object::ID,
        domain: vector<u8>,
    }

    public fun assert_price_not_older_than(arg0: &PriceFeed, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 <= arg0.price.publish_time_ms || v0 - arg0.price.publish_time_ms <= arg1, 11);
    }

    fun assert_reference_fresh_and_within_tolerance(arg0: &ReferencePrice, arg1: &0x2::clock::Clock, arg2: u64, arg3: bool, arg4: u64, arg5: bool) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 <= arg0.price.publish_time_ms || v0 - arg0.price.publish_time_ms <= arg0.max_reference_staleness_ms, 6);
        assert!(deviation_bps(arg2, arg3, arg4, arg5, arg0.price.mantissa, arg0.price.negative, arg0.price.expo, arg0.price.expo_negative) <= arg0.max_deviation_bps, 7);
    }

    public fun attach_reference(arg0: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::ReferenceAdminCap, arg1: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::CapRegistry, arg2: &mut PriceFeed, arg3: vector<u8>, arg4: u64, arg5: bool, arg6: u64, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock) {
        assert!(0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::is_current_reference_admin_cap(arg1, 0x2::object::id<0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::ReferenceAdminCap>(arg0)), 21);
        migrate_if_needed(arg2);
        assert!(0x1::option::is_none<ReferencePrice>(&arg2.reference), 8);
        assert!(arg10 <= 5000, 9);
        assert!(arg11 <= 3600000, 9);
        assert!(arg4 > 0, 10);
        assert!(arg9 <= 0x2::clock::timestamp_ms(arg12) + 5000, 4);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 17);
        assert!(arg3 != arg2.trusted_pubkey, 19);
        let v0 = PriceValue{
            mantissa        : arg4,
            negative        : arg5,
            expo            : arg6,
            expo_negative   : arg7,
            conf            : arg8,
            publish_time_ms : arg9,
        };
        let v1 = ReferencePrice{
            price                             : v0,
            trusted_pubkey                    : arg3,
            max_deviation_bps                 : arg10,
            max_reference_staleness_ms        : arg11,
            last_reference_signer_rotation_ms : 0x2::clock::timestamp_ms(arg12),
            pending_reference_signer_rotation : 0x1::option::none<PendingRotation>(),
        };
        arg2.reference = 0x1::option::some<ReferencePrice>(v1);
        let v2 = ReferenceAttached{feed_id: 0x2::object::id<PriceFeed>(arg2)};
        0x2::event::emit<ReferenceAttached>(v2);
    }

    public fun cancel_rotate_reference_signer(arg0: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::ReferenceAdminCap, arg1: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::CapRegistry, arg2: &mut PriceFeed) {
        assert!(0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::is_current_reference_admin_cap(arg1, 0x2::object::id<0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::ReferenceAdminCap>(arg0)), 21);
        migrate_if_needed(arg2);
        assert!(0x1::option::is_some<ReferencePrice>(&arg2.reference), 5);
        let v0 = 0x1::option::borrow_mut<ReferencePrice>(&mut arg2.reference);
        assert!(0x1::option::is_some<PendingRotation>(&v0.pending_reference_signer_rotation), 15);
        v0.pending_reference_signer_rotation = 0x1::option::none<PendingRotation>();
        let v1 = ReferenceSignerRotationCancelled{
            feed_id    : 0x2::object::id<PriceFeed>(arg2),
            new_pubkey : 0x1::option::borrow<PendingRotation>(&v0.pending_reference_signer_rotation).new_pubkey,
        };
        0x2::event::emit<ReferenceSignerRotationCancelled>(v1);
    }

    public fun cancel_rotate_signer(arg0: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::PriceAdminCap, arg1: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::CapRegistry, arg2: &mut PriceFeed) {
        assert!(0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::is_current_price_admin_cap(arg1, 0x2::object::id<0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::PriceAdminCap>(arg0)), 21);
        migrate_if_needed(arg2);
        assert!(0x1::option::is_some<PendingRotation>(&arg2.pending_signer_rotation), 15);
        arg2.pending_signer_rotation = 0x1::option::none<PendingRotation>();
        let v0 = SignerRotationCancelled{
            feed_id    : 0x2::object::id<PriceFeed>(arg2),
            new_pubkey : 0x1::option::borrow<PendingRotation>(&arg2.pending_signer_rotation).new_pubkey,
        };
        0x2::event::emit<SignerRotationCancelled>(v0);
    }

    fun charge_publish_fee(arg0: &PriceFeed, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.publish_fee, 23);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.fee_recipient);
    }

    public fun create_feed(arg0: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::OracleAdminCap, arg1: &mut 0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::registry::OracleRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1::vector::length<u8>(&arg3) == 32, 17);
        let v0 = PriceValue{
            mantissa        : 0,
            negative        : false,
            expo            : 0,
            expo_negative   : false,
            conf            : 0,
            publish_time_ms : 0,
        };
        let v1 = PriceFeed{
            id                      : 0x2::object::new(arg6),
            symbol                  : arg2,
            price                   : v0,
            trusted_pubkey          : arg3,
            reference               : 0x1::option::none<ReferencePrice>(),
            ema                     : 0x1::option::none<PriceValue>(),
            version                 : 1,
            last_signer_rotation_ms : 0x2::clock::timestamp_ms(arg5),
            retired                 : false,
            pending_signer_rotation : 0x1::option::none<PendingRotation>(),
            publish_fee             : 0,
            fee_recipient           : arg4,
        };
        let v2 = 0x2::object::id<PriceFeed>(&v1);
        0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::registry::register(arg1, arg2, v2);
        let v3 = PriceFeedCreated{
            feed_id : v2,
            symbol  : arg2,
        };
        0x2::event::emit<PriceFeedCreated>(v3);
        0x2::transfer::share_object<PriceFeed>(v1);
        v2
    }

    fun deviation_bps(arg0: u64, arg1: bool, arg2: u64, arg3: bool, arg4: u64, arg5: bool, arg6: u64, arg7: bool) : u64 {
        assert!(arg2 == arg6 && arg3 == arg7, 7);
        if (arg1 != arg5) {
            return 10001
        };
        let v0 = if (arg0 > arg4) {
            ((arg0 - arg4) as u128)
        } else {
            ((arg4 - arg0) as u128)
        };
        let v1 = v0 * 10000 / (arg4 as u128);
        if (v1 > 10001) {
            10001
        } else {
            (v1 as u64)
        }
    }

    public fun finalize_rotate_reference_signer(arg0: &mut PriceFeed, arg1: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::CapRegistry, arg2: &0x2::clock::Clock) {
        migrate_if_needed(arg0);
        assert!(0x1::option::is_some<ReferencePrice>(&arg0.reference), 5);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x1::option::borrow<ReferencePrice>(&arg0.reference);
        assert!(0x1::option::is_some<PendingRotation>(&v1.pending_reference_signer_rotation), 15);
        let v2 = *0x1::option::borrow<PendingRotation>(&v1.pending_reference_signer_rotation);
        assert!(0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::is_current_reference_admin_cap(arg1, v2.requested_by_cap_id), 22);
        assert!(v0 >= v2.requested_at_ms + 86400000, 16);
        assert!(v0 >= arg0.last_signer_rotation_ms + 604800000, 12);
        assert!(v2.new_pubkey != arg0.trusted_pubkey, 19);
        let v3 = 0x1::option::borrow_mut<ReferencePrice>(&mut arg0.reference);
        v3.trusted_pubkey = v2.new_pubkey;
        v3.last_reference_signer_rotation_ms = v0;
        v3.pending_reference_signer_rotation = 0x1::option::none<PendingRotation>();
        let v4 = ReferenceSignerRotated{
            feed_id    : 0x2::object::id<PriceFeed>(arg0),
            new_pubkey : v2.new_pubkey,
        };
        0x2::event::emit<ReferenceSignerRotated>(v4);
    }

    public fun finalize_rotate_reference_signer_immediately(arg0: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::OracleAdminCap, arg1: &mut PriceFeed, arg2: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::CapRegistry, arg3: &0x2::clock::Clock) {
        migrate_if_needed(arg1);
        assert!(0x1::option::is_some<ReferencePrice>(&arg1.reference), 5);
        let v0 = 0x1::option::borrow<ReferencePrice>(&arg1.reference);
        assert!(0x1::option::is_some<PendingRotation>(&v0.pending_reference_signer_rotation), 15);
        let v1 = *0x1::option::borrow<PendingRotation>(&v0.pending_reference_signer_rotation);
        assert!(0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::is_current_reference_admin_cap(arg2, v1.requested_by_cap_id), 22);
        assert!(v1.new_pubkey != arg1.trusted_pubkey, 19);
        let v2 = 0x1::option::borrow_mut<ReferencePrice>(&mut arg1.reference);
        v2.trusted_pubkey = v1.new_pubkey;
        v2.last_reference_signer_rotation_ms = 0x2::clock::timestamp_ms(arg3);
        v2.pending_reference_signer_rotation = 0x1::option::none<PendingRotation>();
        let v3 = ReferenceSignerRotated{
            feed_id    : 0x2::object::id<PriceFeed>(arg1),
            new_pubkey : v1.new_pubkey,
        };
        0x2::event::emit<ReferenceSignerRotated>(v3);
    }

    public fun finalize_rotate_signer(arg0: &mut PriceFeed, arg1: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::CapRegistry, arg2: &0x2::clock::Clock) {
        migrate_if_needed(arg0);
        assert!(0x1::option::is_some<PendingRotation>(&arg0.pending_signer_rotation), 15);
        let v0 = *0x1::option::borrow<PendingRotation>(&arg0.pending_signer_rotation);
        assert!(0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::is_current_price_admin_cap(arg1, v0.requested_by_cap_id), 22);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= v0.requested_at_ms + 86400000, 16);
        if (0x1::option::is_some<ReferencePrice>(&arg0.reference)) {
            let v2 = 0x1::option::borrow<ReferencePrice>(&arg0.reference);
            assert!(v1 >= v2.last_reference_signer_rotation_ms + 604800000, 12);
            assert!(v0.new_pubkey != v2.trusted_pubkey, 19);
        };
        arg0.trusted_pubkey = v0.new_pubkey;
        arg0.last_signer_rotation_ms = v1;
        arg0.pending_signer_rotation = 0x1::option::none<PendingRotation>();
        let v3 = SignerRotated{
            feed_id    : 0x2::object::id<PriceFeed>(arg0),
            new_pubkey : v0.new_pubkey,
        };
        0x2::event::emit<SignerRotated>(v3);
    }

    public fun finalize_rotate_signer_immediately(arg0: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::OracleAdminCap, arg1: &mut PriceFeed, arg2: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::CapRegistry, arg3: &0x2::clock::Clock) {
        migrate_if_needed(arg1);
        assert!(0x1::option::is_some<PendingRotation>(&arg1.pending_signer_rotation), 15);
        let v0 = *0x1::option::borrow<PendingRotation>(&arg1.pending_signer_rotation);
        assert!(0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::is_current_price_admin_cap(arg2, v0.requested_by_cap_id), 22);
        if (0x1::option::is_some<ReferencePrice>(&arg1.reference)) {
            assert!(v0.new_pubkey != 0x1::option::borrow<ReferencePrice>(&arg1.reference).trusted_pubkey, 19);
        };
        arg1.trusted_pubkey = v0.new_pubkey;
        arg1.last_signer_rotation_ms = 0x2::clock::timestamp_ms(arg3);
        arg1.pending_signer_rotation = 0x1::option::none<PendingRotation>();
        let v1 = SignerRotated{
            feed_id    : 0x2::object::id<PriceFeed>(arg1),
            new_pubkey : v0.new_pubkey,
        };
        0x2::event::emit<SignerRotated>(v1);
    }

    public fun get_price_and_ema_no_older_than(arg0: &PriceFeed, arg1: u64, arg2: &0x2::clock::Clock) : (PriceValue, PriceValue) {
        assert_price_not_older_than(arg0, arg1, arg2);
        assert!(0x1::option::is_some<PriceValue>(&arg0.ema), 20);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x1::option::borrow<PriceValue>(&arg0.ema);
        assert!(v0 <= v1.publish_time_ms || v0 - v1.publish_time_ms <= arg1, 11);
        (arg0.price, *v1)
    }

    public fun get_price_no_older_than(arg0: &PriceFeed, arg1: u64, arg2: &0x2::clock::Clock) : PriceValue {
        assert_price_not_older_than(arg0, arg1, arg2);
        arg0.price
    }

    public fun has_reference(arg0: &PriceFeed) : bool {
        0x1::option::is_some<ReferencePrice>(&arg0.reference)
    }

    public fun is_retired(arg0: &PriceFeed) : bool {
        arg0.retired
    }

    public fun max_deviation_bps(arg0: &PriceFeed) : u64 {
        0x1::option::borrow<ReferencePrice>(&arg0.reference).max_deviation_bps
    }

    public fun max_reference_staleness_ms(arg0: &PriceFeed) : u64 {
        0x1::option::borrow<ReferencePrice>(&arg0.reference).max_reference_staleness_ms
    }

    public fun migrate(arg0: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::OracleAdminCap, arg1: &mut PriceFeed) {
        assert!(arg1.version < 1, 1);
        arg1.version = 1;
    }

    fun migrate_if_needed(arg0: &mut PriceFeed) {
        assert!(arg0.version <= 1, 0);
        if (arg0.version < 1) {
            arg0.version = 1;
        };
    }

    public fun post_price(arg0: &mut PriceFeed, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: bool, arg10: u64, arg11: bool, arg12: u64, arg13: u64, arg14: vector<u8>, arg15: 0x2::coin::Coin<0x2::sui::SUI>, arg16: &0x2::clock::Clock) {
        charge_publish_fee(arg0, arg15);
        migrate_if_needed(arg0);
        if (0x1::option::is_some<ReferencePrice>(&arg0.reference)) {
            assert_reference_fresh_and_within_tolerance(0x1::option::borrow<ReferencePrice>(&arg0.reference), arg16, arg1, arg2, arg3, arg4);
        };
        verify_and_write_primary(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg16);
    }

    public fun post_price_with_reference_refresh(arg0: &mut PriceFeed, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: bool, arg10: u64, arg11: bool, arg12: u64, arg13: u64, arg14: vector<u8>, arg15: u64, arg16: bool, arg17: u64, arg18: bool, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: vector<u8>, arg24: 0x2::coin::Coin<0x2::sui::SUI>, arg25: &0x2::clock::Clock) {
        charge_publish_fee(arg0, arg24);
        migrate_if_needed(arg0);
        assert!(0x1::option::is_some<ReferencePrice>(&arg0.reference), 5);
        let v0 = 0x1::option::borrow<ReferencePrice>(&arg0.reference);
        assert!(arg20 > v0.price.publish_time_ms, 3);
        assert!(arg20 <= 0x2::clock::timestamp_ms(arg25) + 5000, 4);
        assert!(arg21 <= 5000, 9);
        assert!(arg22 <= 3600000, 9);
        assert!(arg15 > 0, 10);
        let v1 = ReferencePricePayload{
            symbol                     : arg0.symbol,
            mantissa                   : arg15,
            negative                   : arg16,
            expo                       : arg17,
            expo_negative              : arg18,
            conf                       : arg19,
            publish_time_ms            : arg20,
            max_deviation_bps          : arg21,
            max_reference_staleness_ms : arg22,
            feed_id                    : 0x2::object::id<PriceFeed>(arg0),
            domain                     : b"SHOMEI_REF_V1",
        };
        let v2 = 0x2::bcs::to_bytes<ReferencePricePayload>(&v1);
        assert!(0x2::ed25519::ed25519_verify(&arg23, &v0.trusted_pubkey, &v2), 2);
        let v3 = PriceValue{
            mantissa        : arg15,
            negative        : arg16,
            expo            : arg17,
            expo_negative   : arg18,
            conf            : arg19,
            publish_time_ms : arg20,
        };
        let v4 = ReferencePrice{
            price                             : v3,
            trusted_pubkey                    : 0x1::option::borrow<ReferencePrice>(&arg0.reference).trusted_pubkey,
            max_deviation_bps                 : arg21,
            max_reference_staleness_ms        : arg22,
            last_reference_signer_rotation_ms : 0x1::option::borrow<ReferencePrice>(&arg0.reference).last_reference_signer_rotation_ms,
            pending_reference_signer_rotation : 0x1::option::borrow<ReferencePrice>(&arg0.reference).pending_reference_signer_rotation,
        };
        0x1::option::swap<ReferencePrice>(&mut arg0.reference, v4);
        let v5 = ReferencePosted{
            feed_id                    : 0x2::object::id<PriceFeed>(arg0),
            mantissa                   : arg15,
            negative                   : arg16,
            expo                       : arg17,
            expo_negative              : arg18,
            conf                       : arg19,
            publish_time_ms            : arg20,
            max_deviation_bps          : arg21,
            max_reference_staleness_ms : arg22,
        };
        0x2::event::emit<ReferencePosted>(v5);
        assert_reference_fresh_and_within_tolerance(0x1::option::borrow<ReferencePrice>(&arg0.reference), arg25, arg1, arg2, arg3, arg4);
        verify_and_write_primary(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg25);
    }

    public fun price(arg0: &PriceFeed) : &PriceValue {
        &arg0.price
    }

    public fun price_and_ema(arg0: &PriceFeed) : (&PriceValue, &PriceValue) {
        (&arg0.price, 0x1::option::borrow<PriceValue>(&arg0.ema))
    }

    public fun price_value_conf(arg0: &PriceValue) : u64 {
        arg0.conf
    }

    public fun price_value_expo(arg0: &PriceValue) : u64 {
        arg0.expo
    }

    public fun price_value_expo_is_negative(arg0: &PriceValue) : bool {
        arg0.expo_negative
    }

    public fun price_value_is_negative(arg0: &PriceValue) : bool {
        arg0.negative
    }

    public fun price_value_mantissa(arg0: &PriceValue) : u64 {
        arg0.mantissa
    }

    public fun price_value_publish_time_ms(arg0: &PriceValue) : u64 {
        arg0.publish_time_ms
    }

    public fun publish_fee(arg0: &PriceFeed) : u64 {
        arg0.publish_fee
    }

    public fun reference_price(arg0: &PriceFeed) : &PriceValue {
        &0x1::option::borrow<ReferencePrice>(&arg0.reference).price
    }

    public fun reference_trusted_pubkey(arg0: &PriceFeed) : vector<u8> {
        0x1::option::borrow<ReferencePrice>(&arg0.reference).trusted_pubkey
    }

    public fun request_rotate_reference_signer(arg0: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::ReferenceAdminCap, arg1: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::CapRegistry, arg2: &mut PriceFeed, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert!(0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::is_current_reference_admin_cap(arg1, 0x2::object::id<0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::ReferenceAdminCap>(arg0)), 21);
        migrate_if_needed(arg2);
        assert!(0x1::option::is_some<ReferencePrice>(&arg2.reference), 5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x1::option::borrow_mut<ReferencePrice>(&mut arg2.reference);
        assert!(0x1::option::is_none<PendingRotation>(&v1.pending_reference_signer_rotation), 14);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 17);
        assert!(arg3 != arg2.trusted_pubkey, 19);
        let v2 = 0x2::object::id<0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::ReferenceAdminCap>(arg0);
        let v3 = PendingRotation{
            new_pubkey          : arg3,
            requested_at_ms     : v0,
            requested_by_cap_id : v2,
        };
        v1.pending_reference_signer_rotation = 0x1::option::some<PendingRotation>(v3);
        let v4 = ReferenceSignerRotationRequested{
            feed_id             : 0x2::object::id<PriceFeed>(arg2),
            new_pubkey          : arg3,
            requested_at_ms     : v0,
            requested_by_cap_id : v2,
        };
        0x2::event::emit<ReferenceSignerRotationRequested>(v4);
    }

    public fun request_rotate_signer(arg0: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::PriceAdminCap, arg1: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::CapRegistry, arg2: &mut PriceFeed, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert!(0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::is_current_price_admin_cap(arg1, 0x2::object::id<0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::PriceAdminCap>(arg0)), 21);
        migrate_if_needed(arg2);
        assert!(0x1::option::is_none<PendingRotation>(&arg2.pending_signer_rotation), 14);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 17);
        if (0x1::option::is_some<ReferencePrice>(&arg2.reference)) {
            assert!(arg3 != 0x1::option::borrow<ReferencePrice>(&arg2.reference).trusted_pubkey, 19);
        };
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::object::id<0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::PriceAdminCap>(arg0);
        let v2 = PendingRotation{
            new_pubkey          : arg3,
            requested_at_ms     : v0,
            requested_by_cap_id : v1,
        };
        arg2.pending_signer_rotation = 0x1::option::some<PendingRotation>(v2);
        let v3 = SignerRotationRequested{
            feed_id             : 0x2::object::id<PriceFeed>(arg2),
            new_pubkey          : arg3,
            requested_at_ms     : v0,
            requested_by_cap_id : v1,
        };
        0x2::event::emit<SignerRotationRequested>(v3);
    }

    public fun retire_feed(arg0: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::OracleAdminCap, arg1: &mut 0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::registry::OracleRegistry, arg2: &mut PriceFeed) {
        assert!(!arg2.retired, 13);
        migrate_if_needed(arg2);
        arg2.retired = true;
        0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::registry::deregister(arg1, arg2.symbol);
        let v0 = FeedRetired{
            feed_id : 0x2::object::id<PriceFeed>(arg2),
            symbol  : arg2.symbol,
        };
        0x2::event::emit<FeedRetired>(v0);
    }

    public fun set_publish_fee(arg0: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::OracleAdminCap, arg1: &mut PriceFeed, arg2: u64, arg3: address) {
        migrate_if_needed(arg1);
        assert!(arg2 <= 1000000, 24);
        arg1.publish_fee = arg2;
        arg1.fee_recipient = arg3;
        let v0 = PublishFeeUpdated{
            feed_id           : 0x2::object::id<PriceFeed>(arg1),
            old_publish_fee   : arg1.publish_fee,
            new_publish_fee   : arg2,
            old_fee_recipient : arg1.fee_recipient,
            new_fee_recipient : arg3,
        };
        0x2::event::emit<PublishFeeUpdated>(v0);
    }

    public fun set_reference_tolerance(arg0: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::ReferenceAdminCap, arg1: &0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::CapRegistry, arg2: &mut PriceFeed, arg3: u64, arg4: u64) {
        assert!(0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::is_current_reference_admin_cap(arg1, 0x2::object::id<0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::oracle_admin::ReferenceAdminCap>(arg0)), 21);
        migrate_if_needed(arg2);
        assert!(arg3 <= 5000, 9);
        assert!(arg4 <= 3600000, 9);
        assert!(0x1::option::is_some<ReferencePrice>(&arg2.reference), 5);
        let v0 = 0x1::option::borrow_mut<ReferencePrice>(&mut arg2.reference);
        v0.max_deviation_bps = arg3;
        v0.max_reference_staleness_ms = arg4;
        let v1 = ReferenceToleranceUpdated{
            feed_id                        : 0x2::object::id<PriceFeed>(arg2),
            old_max_deviation_bps          : v0.max_deviation_bps,
            new_max_deviation_bps          : arg3,
            old_max_reference_staleness_ms : v0.max_reference_staleness_ms,
            new_max_reference_staleness_ms : arg4,
        };
        0x2::event::emit<ReferenceToleranceUpdated>(v1);
    }

    public fun symbol(arg0: &PriceFeed) : vector<u8> {
        arg0.symbol
    }

    public fun trusted_pubkey(arg0: &PriceFeed) : vector<u8> {
        arg0.trusted_pubkey
    }

    fun verify_and_write_primary(arg0: &mut PriceFeed, arg1: u64, arg2: bool, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: bool, arg10: u64, arg11: bool, arg12: u64, arg13: u64, arg14: vector<u8>, arg15: &0x2::clock::Clock) {
        assert!(!arg0.retired, 13);
        assert!(arg6 > arg0.price.publish_time_ms, 3);
        assert!(arg6 <= 0x2::clock::timestamp_ms(arg15) + 5000, 4);
        let v0 = PricePayload{
            symbol              : arg0.symbol,
            mantissa            : arg1,
            negative            : arg2,
            expo                : arg3,
            expo_negative       : arg4,
            conf                : arg5,
            publish_time_ms     : arg6,
            has_ema             : arg7,
            ema_mantissa        : arg8,
            ema_negative        : arg9,
            ema_expo            : arg10,
            ema_expo_negative   : arg11,
            ema_conf            : arg12,
            ema_publish_time_ms : arg13,
            feed_id             : 0x2::object::id<PriceFeed>(arg0),
            domain              : b"SHOMEI_PRICE_V1",
        };
        let v1 = 0x2::bcs::to_bytes<PricePayload>(&v0);
        assert!(0x2::ed25519::ed25519_verify(&arg14, &arg0.trusted_pubkey, &v1), 2);
        let v2 = PriceValue{
            mantissa        : arg1,
            negative        : arg2,
            expo            : arg3,
            expo_negative   : arg4,
            conf            : arg5,
            publish_time_ms : arg6,
        };
        arg0.price = v2;
        if (arg7) {
            assert!(arg13 <= 0x2::clock::timestamp_ms(arg15) + 5000, 4);
            let v3 = PriceValue{
                mantissa        : arg8,
                negative        : arg9,
                expo            : arg10,
                expo_negative   : arg11,
                conf            : arg12,
                publish_time_ms : arg13,
            };
            arg0.ema = 0x1::option::some<PriceValue>(v3);
        };
        let v4 = PricePosted{
            feed_id             : 0x2::object::id<PriceFeed>(arg0),
            mantissa            : arg1,
            negative            : arg2,
            expo                : arg3,
            expo_negative       : arg4,
            conf                : arg5,
            publish_time_ms     : arg6,
            has_ema             : arg7,
            ema_mantissa        : arg8,
            ema_negative        : arg9,
            ema_expo            : arg10,
            ema_expo_negative   : arg11,
            ema_conf            : arg12,
            ema_publish_time_ms : arg13,
        };
        0x2::event::emit<PricePosted>(v4);
    }

    public fun version(arg0: &PriceFeed) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

