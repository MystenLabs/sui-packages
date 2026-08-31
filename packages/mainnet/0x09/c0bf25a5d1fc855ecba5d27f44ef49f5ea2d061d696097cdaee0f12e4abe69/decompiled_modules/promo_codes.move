module 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::promo_codes {
    struct PromoCode has store, key {
        id: 0x2::object::UID,
        vessel_id: 0x2::object::ID,
        code_hash: vector<u8>,
        kind: u8,
        value: u64,
        applicable_tiers: vector<u8>,
        starts_at_ms: u64,
        expires_at_ms: u64,
        max_uses: u64,
        uses: u64,
        active: bool,
    }

    struct PromoCreated has copy, drop {
        promo_id: 0x2::object::ID,
        vessel_id: 0x2::object::ID,
        code_hash: vector<u8>,
        kind: u8,
        value: u64,
        expires_at_ms: u64,
    }

    struct PromoRevoked has copy, drop {
        promo_id: 0x2::object::ID,
    }

    struct PromoConsumed has copy, drop {
        promo_id: 0x2::object::ID,
        vessel_id: 0x2::object::ID,
        new_uses: u64,
    }

    public fun consume_promo(arg0: &mut PromoCode, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        assert!(arg0.vessel_id == arg1, 400);
        assert!(arg0.active, 402);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 >= arg0.starts_at_ms, 404);
        assert!(v0 < arg0.expires_at_ms, 403);
        if (arg0.max_uses > 0) {
            assert!(arg0.uses < arg0.max_uses, 405);
        };
        if (!0x1::vector::is_empty<u8>(&arg0.applicable_tiers)) {
            assert!(0x1::vector::contains<u8>(&arg0.applicable_tiers, &arg3), 406);
        };
        assert!(0x1::hash::sha2_256(arg2) == arg0.code_hash, 401);
        let v1 = if (arg0.kind == 0) {
            let v2 = arg4 * arg0.value / 10000;
            if (v2 >= arg4) {
                0
            } else {
                arg4 - v2
            }
        } else if (arg0.value >= arg4) {
            0
        } else {
            arg4 - arg0.value
        };
        arg0.uses = arg0.uses + 1;
        let v3 = PromoConsumed{
            promo_id  : 0x2::object::id<PromoCode>(arg0),
            vessel_id : arg0.vessel_id,
            new_uses  : arg0.uses,
        };
        0x2::event::emit<PromoConsumed>(v3);
        v1
    }

    public fun create_promo(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : PromoCode {
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::owner_cap_vessel_id(arg0) == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 400);
        assert!(arg3 == 0 || arg3 == 1, 407);
        if (arg3 == 0) {
            assert!(arg4 <= 10000, 408);
        };
        let v0 = PromoCode{
            id               : 0x2::object::new(arg9),
            vessel_id        : 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1),
            code_hash        : arg2,
            kind             : arg3,
            value            : arg4,
            applicable_tiers : arg5,
            starts_at_ms     : arg6,
            expires_at_ms    : arg7,
            max_uses         : arg8,
            uses             : 0,
            active           : true,
        };
        let v1 = PromoCreated{
            promo_id      : 0x2::object::id<PromoCode>(&v0),
            vessel_id     : v0.vessel_id,
            code_hash     : v0.code_hash,
            kind          : arg3,
            value         : arg4,
            expires_at_ms : arg7,
        };
        0x2::event::emit<PromoCreated>(v1);
        v0
    }

    public fun kind_fixed_off() : u8 {
        1
    }

    public fun kind_percent_off() : u8 {
        0
    }

    public fun promo_active(arg0: &PromoCode) : bool {
        arg0.active
    }

    public fun promo_code_hash(arg0: &PromoCode) : vector<u8> {
        arg0.code_hash
    }

    public fun promo_expires_at_ms(arg0: &PromoCode) : u64 {
        arg0.expires_at_ms
    }

    public fun promo_kind(arg0: &PromoCode) : u8 {
        arg0.kind
    }

    public fun promo_max_uses(arg0: &PromoCode) : u64 {
        arg0.max_uses
    }

    public fun promo_starts_at_ms(arg0: &PromoCode) : u64 {
        arg0.starts_at_ms
    }

    public fun promo_uses(arg0: &PromoCode) : u64 {
        arg0.uses
    }

    public fun promo_uses_remaining(arg0: &PromoCode) : u64 {
        if (arg0.max_uses == 0) {
            18446744073709551615
        } else if (arg0.uses >= arg0.max_uses) {
            0
        } else {
            arg0.max_uses - arg0.uses
        }
    }

    public fun promo_value(arg0: &PromoCode) : u64 {
        arg0.value
    }

    public fun promo_vessel_id(arg0: &PromoCode) : 0x2::object::ID {
        arg0.vessel_id
    }

    public fun revoke_promo(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg1: &mut PromoCode, arg2: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity) {
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::owner_cap_vessel_id(arg0) == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg2), 400);
        arg1.active = false;
        let v0 = PromoRevoked{promo_id: 0x2::object::id<PromoCode>(arg1)};
        0x2::event::emit<PromoRevoked>(v0);
    }

    // decompiled from Move bytecode v7
}

