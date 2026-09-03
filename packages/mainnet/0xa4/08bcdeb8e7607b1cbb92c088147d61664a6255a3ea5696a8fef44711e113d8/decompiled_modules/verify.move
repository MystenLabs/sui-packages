module 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::verify {
    struct PackageMarker has drop {
        dummy_field: bool,
    }

    struct ValueUpdate has copy, drop {
        sid: u256,
        timestamp: u64,
        v: u128,
    }

    struct SviUpdate has copy, drop {
        sid: u256,
        timestamp: u64,
        svi_a_magnitude: u128,
        svi_a_is_negative: bool,
        svi_b: u128,
        svi_sigma: u128,
        svi_rho_magnitude: u128,
        svi_rho_is_negative: bool,
        svi_m_magnitude: u128,
        svi_m_is_negative: bool,
    }

    struct ValueAbsoluteUpdate has copy, drop {
        sid: u256,
        v: u128,
    }

    struct SviAbsoluteUpdate has copy, drop {
        sid: u256,
        svi_a_magnitude: u128,
        svi_a_is_negative: bool,
        svi_b: u128,
        svi_sigma: u128,
        svi_rho_magnitude: u128,
        svi_rho_is_negative: bool,
        svi_m_magnitude: u128,
        svi_m_is_negative: bool,
    }

    struct ValueBatch {
        timestamp: u64,
        updates: vector<ValueUpdate>,
    }

    struct SviBatch {
        timestamp: u64,
        updates: vector<SviUpdate>,
    }

    struct ValueAbsoluteBatch {
        timestamp: u64,
        updates: vector<ValueAbsoluteUpdate>,
    }

    struct SviAbsoluteBatch {
        timestamp: u64,
        updates: vector<SviAbsoluteUpdate>,
    }

    struct BatchVerified has copy, drop {
        batch_kind: u8,
        timestamp: u64,
        update_count: u64,
    }

    public fun into_svi_absolute_updates(arg0: SviAbsoluteBatch) : vector<SviAbsoluteUpdate> {
        let SviAbsoluteBatch {
            timestamp : _,
            updates   : v1,
        } = arg0;
        v1
    }

    public fun into_svi_updates(arg0: SviBatch) : vector<SviUpdate> {
        let SviBatch {
            timestamp : _,
            updates   : v1,
        } = arg0;
        v1
    }

    public fun into_value_absolute_updates(arg0: ValueAbsoluteBatch) : vector<ValueAbsoluteUpdate> {
        let ValueAbsoluteBatch {
            timestamp : _,
            updates   : v1,
        } = arg0;
        v1
    }

    public fun into_value_updates(arg0: ValueBatch) : vector<ValueUpdate> {
        let ValueBatch {
            timestamp : _,
            updates   : v1,
        } = arg0;
        v1
    }

    fun peel_svi_absolute_updates(arg0: &mut 0x2::bcs::BCS) : vector<SviAbsoluteUpdate> {
        let v0 = 0x1::vector::empty<SviAbsoluteUpdate>();
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_vec_length(arg0)) {
            let v2 = SviAbsoluteUpdate{
                sid                 : 0x2::bcs::peel_u256(arg0),
                svi_a_magnitude     : 0x2::bcs::peel_u128(arg0),
                svi_a_is_negative   : 0x2::bcs::peel_bool(arg0),
                svi_b               : 0x2::bcs::peel_u128(arg0),
                svi_sigma           : 0x2::bcs::peel_u128(arg0),
                svi_rho_magnitude   : 0x2::bcs::peel_u128(arg0),
                svi_rho_is_negative : 0x2::bcs::peel_bool(arg0),
                svi_m_magnitude     : 0x2::bcs::peel_u128(arg0),
                svi_m_is_negative   : 0x2::bcs::peel_bool(arg0),
            };
            0x1::vector::push_back<SviAbsoluteUpdate>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun peel_svi_updates(arg0: &mut 0x2::bcs::BCS) : vector<SviUpdate> {
        let v0 = 0x1::vector::empty<SviUpdate>();
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_vec_length(arg0)) {
            let v2 = SviUpdate{
                sid                 : 0x2::bcs::peel_u256(arg0),
                timestamp           : 0x2::bcs::peel_u64(arg0),
                svi_a_magnitude     : 0x2::bcs::peel_u128(arg0),
                svi_a_is_negative   : 0x2::bcs::peel_bool(arg0),
                svi_b               : 0x2::bcs::peel_u128(arg0),
                svi_sigma           : 0x2::bcs::peel_u128(arg0),
                svi_rho_magnitude   : 0x2::bcs::peel_u128(arg0),
                svi_rho_is_negative : 0x2::bcs::peel_bool(arg0),
                svi_m_magnitude     : 0x2::bcs::peel_u128(arg0),
                svi_m_is_negative   : 0x2::bcs::peel_bool(arg0),
            };
            0x1::vector::push_back<SviUpdate>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun peel_value_absolute_updates(arg0: &mut 0x2::bcs::BCS) : vector<ValueAbsoluteUpdate> {
        let v0 = 0x1::vector::empty<ValueAbsoluteUpdate>();
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_vec_length(arg0)) {
            let v2 = ValueAbsoluteUpdate{
                sid : 0x2::bcs::peel_u256(arg0),
                v   : 0x2::bcs::peel_u128(arg0),
            };
            0x1::vector::push_back<ValueAbsoluteUpdate>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun peel_value_updates(arg0: &mut 0x2::bcs::BCS) : vector<ValueUpdate> {
        let v0 = 0x1::vector::empty<ValueUpdate>();
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_vec_length(arg0)) {
            let v2 = ValueUpdate{
                sid       : 0x2::bcs::peel_u256(arg0),
                timestamp : 0x2::bcs::peel_u64(arg0),
                v         : 0x2::bcs::peel_u128(arg0),
            };
            0x1::vector::push_back<ValueUpdate>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun svi_absolute_batch_timestamp(arg0: &SviAbsoluteBatch) : u64 {
        arg0.timestamp
    }

    public fun svi_absolute_fields(arg0: &SviAbsoluteUpdate) : (u128, bool, u128, u128, u128, bool, u128, bool) {
        (arg0.svi_a_magnitude, arg0.svi_a_is_negative, arg0.svi_b, arg0.svi_sigma, arg0.svi_rho_magnitude, arg0.svi_rho_is_negative, arg0.svi_m_magnitude, arg0.svi_m_is_negative)
    }

    public fun svi_absolute_sid(arg0: &SviAbsoluteUpdate) : u256 {
        arg0.sid
    }

    public fun svi_batch_timestamp(arg0: &SviBatch) : u64 {
        arg0.timestamp
    }

    public fun svi_fields(arg0: &SviUpdate) : (u128, bool, u128, u128, u128, bool, u128, bool) {
        (arg0.svi_a_magnitude, arg0.svi_a_is_negative, arg0.svi_b, arg0.svi_sigma, arg0.svi_rho_magnitude, arg0.svi_rho_is_negative, arg0.svi_m_magnitude, arg0.svi_m_is_negative)
    }

    public fun svi_sid(arg0: &SviUpdate) : u256 {
        arg0.sid
    }

    public fun svi_timestamp(arg0: &SviUpdate) : u64 {
        arg0.timestamp
    }

    public fun value_absolute_batch_timestamp(arg0: &ValueAbsoluteBatch) : u64 {
        arg0.timestamp
    }

    public fun value_absolute_sid(arg0: &ValueAbsoluteUpdate) : u256 {
        arg0.sid
    }

    public fun value_absolute_v(arg0: &ValueAbsoluteUpdate) : u128 {
        arg0.v
    }

    public fun value_batch_timestamp(arg0: &ValueBatch) : u64 {
        arg0.timestamp
    }

    public fun value_sid(arg0: &ValueUpdate) : u256 {
        arg0.sid
    }

    public fun value_timestamp(arg0: &ValueUpdate) : u64 {
        arg0.timestamp
    }

    public fun value_v(arg0: &ValueUpdate) : u128 {
        arg0.v
    }

    public fun verify_and_create_svi_absolute_batch(arg0: &0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::registry::SignerRegistry, arg1: vector<u8>) : SviAbsoluteBatch {
        let (v0, v1) = verify_header(arg0, arg1, 3);
        let v2 = v1;
        let v3 = &mut v2;
        let v4 = peel_svi_absolute_updates(v3);
        let v5 = 0x2::bcs::into_remainder_bytes(v2);
        assert!(0x1::vector::is_empty<u8>(&v5), 4);
        assert!(!0x1::vector::is_empty<SviAbsoluteUpdate>(&v4), 5);
        let v6 = BatchVerified{
            batch_kind   : 3,
            timestamp    : v0,
            update_count : 0x1::vector::length<SviAbsoluteUpdate>(&v4),
        };
        0x2::event::emit<BatchVerified>(v6);
        SviAbsoluteBatch{
            timestamp : v0,
            updates   : v4,
        }
    }

    public fun verify_and_create_svi_batch(arg0: &0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::registry::SignerRegistry, arg1: vector<u8>) : SviBatch {
        let (v0, v1) = verify_header(arg0, arg1, 1);
        let v2 = v1;
        let v3 = &mut v2;
        let v4 = peel_svi_updates(v3);
        let v5 = 0x2::bcs::into_remainder_bytes(v2);
        assert!(0x1::vector::is_empty<u8>(&v5), 4);
        assert!(!0x1::vector::is_empty<SviUpdate>(&v4), 5);
        let v6 = BatchVerified{
            batch_kind   : 1,
            timestamp    : v0,
            update_count : 0x1::vector::length<SviUpdate>(&v4),
        };
        0x2::event::emit<BatchVerified>(v6);
        SviBatch{
            timestamp : v0,
            updates   : v4,
        }
    }

    public fun verify_and_create_value_absolute_batch(arg0: &0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::registry::SignerRegistry, arg1: vector<u8>) : ValueAbsoluteBatch {
        let (v0, v1) = verify_header(arg0, arg1, 2);
        let v2 = v1;
        let v3 = &mut v2;
        let v4 = peel_value_absolute_updates(v3);
        let v5 = 0x2::bcs::into_remainder_bytes(v2);
        assert!(0x1::vector::is_empty<u8>(&v5), 4);
        assert!(!0x1::vector::is_empty<ValueAbsoluteUpdate>(&v4), 5);
        let v6 = BatchVerified{
            batch_kind   : 2,
            timestamp    : v0,
            update_count : 0x1::vector::length<ValueAbsoluteUpdate>(&v4),
        };
        0x2::event::emit<BatchVerified>(v6);
        ValueAbsoluteBatch{
            timestamp : v0,
            updates   : v4,
        }
    }

    public fun verify_and_create_value_batch(arg0: &0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::registry::SignerRegistry, arg1: vector<u8>) : ValueBatch {
        let (v0, v1) = verify_header(arg0, arg1, 0);
        let v2 = v1;
        let v3 = &mut v2;
        let v4 = peel_value_updates(v3);
        let v5 = 0x2::bcs::into_remainder_bytes(v2);
        assert!(0x1::vector::is_empty<u8>(&v5), 4);
        assert!(!0x1::vector::is_empty<ValueUpdate>(&v4), 5);
        let v6 = BatchVerified{
            batch_kind   : 0,
            timestamp    : v0,
            update_count : 0x1::vector::length<ValueUpdate>(&v4),
        };
        0x2::event::emit<BatchVerified>(v6);
        ValueBatch{
            timestamp : v0,
            updates   : v4,
        }
    }

    fun verify_header(arg0: &0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::registry::SignerRegistry, arg1: vector<u8>, arg2: u8) : (u64, 0x2::bcs::BCS) {
        assert!(!0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::registry::is_paused(arg0), 7);
        assert!(0x1::vector::length<u8>(&arg1) > 65, 1);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = b"";
        let v2 = 0;
        while (v2 < 65) {
            0x1::vector::push_back<u8>(&mut v1, 0x2::bcs::peel_u8(&mut v0));
            v2 = v2 + 1;
        };
        let v3 = 0x2::bcs::into_remainder_bytes(v0);
        let v4 = 0x2::bcs::new(v3);
        assert!(0x2::bcs::peel_u8(&mut v4) == arg2, 6);
        let v5 = 0x1::type_name::original_id<PackageMarker>();
        let v6 = 0x2::bcs::to_bytes<address>(&v5);
        0x1::vector::append<u8>(&mut v6, v3);
        assert!(0x2::ecdsa_k1::secp256k1_ecrecover(&v1, &v6, 0) == 0xa408bcdeb8e7607b1cbb92c088147d61664a6255a3ea5696a8fef44711e113d8::registry::signer_pubkey(arg0), 2);
        (0x2::bcs::peel_u64(&mut v4), v4)
    }

    // decompiled from Move bytecode v7
}

