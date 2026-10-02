module 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::order {
    struct OrderKey has copy, drop, store {
        account_epoch: u64,
        session_key_id: vector<u8>,
        nonce: u64,
    }

    struct OrderState has store {
        order_hash: vector<u8>,
        expiration_ms: u64,
        total_filled_quantity_e6: u64,
        total_executed_quote_e6: u64,
        maker_filled_quantity_e6: u64,
        taker_executed_quote_e6: u64,
        taker_risk_base_e6: u64,
        taker_fee_paid_e6: u64,
        cancelled: bool,
    }

    struct SessionKey has store {
        public_key: vector<u8>,
        valid_until_ms: u64,
        max_notional_per_order_e6: u64,
        nonce_floor: u64,
        revoked: bool,
    }

    struct OrderV1 has copy, drop {
        version: u8,
        chain_identifier: vector<u8>,
        package_id: address,
        exchange_id: address,
        account_id: address,
        account_epoch: u64,
        market_id: address,
        session_key_id: vector<u8>,
        outcome: u8,
        side: u8,
        order_type: u8,
        flags: u8,
        limit_price_e6: u64,
        quantity_e6: u64,
        expiration_ms: u64,
        nonce: u64,
        salt: u128,
        max_fee_bps: u64,
    }

    public fun account_epoch(arg0: &OrderV1) : u64 {
        arg0.account_epoch
    }

    public fun account_id(arg0: &OrderV1) : address {
        arg0.account_id
    }

    public(friend) fun apply_fill(arg0: &mut OrderState, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64) {
        arg0.total_filled_quantity_e6 = arg0.total_filled_quantity_e6 + arg1;
        arg0.total_executed_quote_e6 = arg0.total_executed_quote_e6 + arg2;
        if (arg3) {
            arg0.maker_filled_quantity_e6 = arg0.maker_filled_quantity_e6 + arg1;
        } else {
            arg0.taker_executed_quote_e6 = arg0.taker_executed_quote_e6 + arg2;
            arg0.taker_risk_base_e6 = arg0.taker_risk_base_e6 + arg4;
            arg0.taker_fee_paid_e6 = arg0.taker_fee_paid_e6 + arg5;
        };
    }

    public fun assert_session_key_authorizes(arg0: &SessionKey, arg1: &OrderV1, arg2: u64) {
        assert!(!arg0.revoked, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::session_key_revoked());
        assert!(arg2 < arg0.valid_until_ms, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::session_key_expired());
        assert!(arg1.quantity_e6 <= arg0.max_notional_per_order_e6, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::session_notional_exceeded());
        assert!(arg1.nonce >= arg0.nonce_floor, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::nonce_below_floor());
    }

    public fun chain_identifier(arg0: &OrderV1) : vector<u8> {
        arg0.chain_identifier
    }

    public fun decode_order(arg0: vector<u8>) : OrderV1 {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::peel_u8(&mut v0);
        assert!(v1 == 1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::unsupported_order_version());
        let v2 = &mut v0;
        let v3 = &mut v0;
        let v4 = &mut v0;
        let v5 = &mut v0;
        let v6 = &mut v0;
        let v7 = &mut v0;
        let v8 = 0x2::bcs::peel_u8(&mut v0);
        assert!(v8 <= 1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bad_order_bytes());
        let v9 = 0x2::bcs::peel_u8(&mut v0);
        assert!(v9 <= 1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bad_order_bytes());
        let v10 = 0x2::bcs::peel_u8(&mut v0);
        assert!(v10 <= 3, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bad_order_bytes());
        let v11 = 0x2::bcs::peel_u8(&mut v0);
        assert!(v11 & (1 ^ 255) == 0, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bad_order_bytes());
        let v12 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v12), 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bad_order_bytes());
        OrderV1{
            version          : v1,
            chain_identifier : peel_fixed_bytes(v2, 4),
            package_id       : peel_address_vec(v3),
            exchange_id      : peel_address_vec(v4),
            account_id       : peel_address_vec(v5),
            account_epoch    : 0x2::bcs::peel_u64(&mut v0),
            market_id        : peel_address_vec(v6),
            session_key_id   : peel_fixed_bytes(v7, 32),
            outcome          : v8,
            side             : v9,
            order_type       : v10,
            flags            : v11,
            limit_price_e6   : 0x2::bcs::peel_u64(&mut v0),
            quantity_e6      : 0x2::bcs::peel_u64(&mut v0),
            expiration_ms    : 0x2::bcs::peel_u64(&mut v0),
            nonce            : 0x2::bcs::peel_u64(&mut v0),
            salt             : 0x2::bcs::peel_u128(&mut v0),
            max_fee_bps      : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public(friend) fun destroy_order_state(arg0: OrderState) {
        let OrderState {
            order_hash               : _,
            expiration_ms            : _,
            total_filled_quantity_e6 : _,
            total_executed_quote_e6  : _,
            maker_filled_quantity_e6 : _,
            taker_executed_quote_e6  : _,
            taker_risk_base_e6       : _,
            taker_fee_paid_e6        : _,
            cancelled                : _,
        } = arg0;
    }

    public fun exchange_id(arg0: &OrderV1) : address {
        arg0.exchange_id
    }

    public fun expiration_ms(arg0: &OrderV1) : u64 {
        arg0.expiration_ms
    }

    public fun flags(arg0: &OrderV1) : u8 {
        arg0.flags
    }

    public fun key_max_notional_per_order_e6(arg0: &SessionKey) : u64 {
        arg0.max_notional_per_order_e6
    }

    public fun key_nonce_floor(arg0: &SessionKey) : u64 {
        arg0.nonce_floor
    }

    public fun key_public_key(arg0: &SessionKey) : vector<u8> {
        arg0.public_key
    }

    public fun key_revoked(arg0: &SessionKey) : bool {
        arg0.revoked
    }

    public fun key_valid_until_ms(arg0: &SessionKey) : u64 {
        arg0.valid_until_ms
    }

    public fun limit_price_e6(arg0: &OrderV1) : u64 {
        arg0.limit_price_e6
    }

    public fun market_id(arg0: &OrderV1) : address {
        arg0.market_id
    }

    public fun max_fee_bps(arg0: &OrderV1) : u64 {
        arg0.max_fee_bps
    }

    public(friend) fun new_order_key(arg0: u64, arg1: vector<u8>, arg2: u64) : OrderKey {
        OrderKey{
            account_epoch  : arg0,
            session_key_id : arg1,
            nonce          : arg2,
        }
    }

    public(friend) fun new_order_state(arg0: vector<u8>, arg1: u64) : OrderState {
        OrderState{
            order_hash               : arg0,
            expiration_ms            : arg1,
            total_filled_quantity_e6 : 0,
            total_executed_quote_e6  : 0,
            maker_filled_quantity_e6 : 0,
            taker_executed_quote_e6  : 0,
            taker_risk_base_e6       : 0,
            taker_fee_paid_e6        : 0,
            cancelled                : false,
        }
    }

    public(friend) fun new_session_key(arg0: vector<u8>, arg1: u64, arg2: u64) : SessionKey {
        SessionKey{
            public_key                : arg0,
            valid_until_ms            : arg1,
            max_notional_per_order_e6 : arg2,
            nonce_floor               : 0,
            revoked                   : false,
        }
    }

    public fun nonce(arg0: &OrderV1) : u64 {
        arg0.nonce
    }

    public fun order_hash(arg0: &vector<u8>) : vector<u8> {
        let v0 = b"FATHOM_ORDER_V1";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::hash::blake2b256(&v0)
    }

    public fun order_key_epoch(arg0: &OrderKey) : u64 {
        arg0.account_epoch
    }

    public fun order_key_nonce(arg0: &OrderKey) : u64 {
        arg0.nonce
    }

    public fun order_key_session_key_id(arg0: &OrderKey) : vector<u8> {
        arg0.session_key_id
    }

    public fun order_type(arg0: &OrderV1) : u8 {
        arg0.order_type
    }

    public fun outcome(arg0: &OrderV1) : u8 {
        arg0.outcome
    }

    public fun package_id(arg0: &OrderV1) : address {
        arg0.package_id
    }

    fun peel_address_vec(arg0: &mut 0x2::bcs::BCS) : address {
        0x2::address::from_bytes(peel_fixed_bytes(arg0, 32))
    }

    fun peel_fixed_bytes(arg0: &mut 0x2::bcs::BCS, arg1: u64) : vector<u8> {
        let v0 = 0x2::bcs::peel_vec_u8(arg0);
        assert!(0x1::vector::length<u8>(&v0) == arg1, 0x2a8f7893ee86751edc9eab38030008ef6e95201698ff621df82c2c688f32c53b::errors::bad_order_bytes());
        v0
    }

    public fun quantity_e6(arg0: &OrderV1) : u64 {
        arg0.quantity_e6
    }

    public fun session_key_id(arg0: &OrderV1) : vector<u8> {
        arg0.session_key_id
    }

    public fun session_key_id_from_public_key(arg0: &vector<u8>) : vector<u8> {
        0x2::hash::blake2b256(arg0)
    }

    public(friend) fun set_cancelled(arg0: &mut OrderState) {
        arg0.cancelled = true;
    }

    public(friend) fun set_nonce_floor(arg0: &mut SessionKey, arg1: u64) {
        arg0.nonce_floor = arg1;
    }

    public(friend) fun set_revoked(arg0: &mut SessionKey) {
        arg0.revoked = true;
    }

    public fun side(arg0: &OrderV1) : u8 {
        arg0.side
    }

    public fun state_cancelled(arg0: &OrderState) : bool {
        arg0.cancelled
    }

    public fun state_expiration_ms(arg0: &OrderState) : u64 {
        arg0.expiration_ms
    }

    public fun state_maker_filled(arg0: &OrderState) : u64 {
        arg0.maker_filled_quantity_e6
    }

    public fun state_order_hash(arg0: &OrderState) : vector<u8> {
        arg0.order_hash
    }

    public fun state_taker_executed_quote(arg0: &OrderState) : u64 {
        arg0.taker_executed_quote_e6
    }

    public fun state_taker_fee_paid(arg0: &OrderState) : u64 {
        arg0.taker_fee_paid_e6
    }

    public fun state_taker_risk_base(arg0: &OrderState) : u64 {
        arg0.taker_risk_base_e6
    }

    public fun state_total_executed_quote(arg0: &OrderState) : u64 {
        arg0.total_executed_quote_e6
    }

    public fun state_total_filled(arg0: &OrderState) : u64 {
        arg0.total_filled_quantity_e6
    }

    public fun verify_order_signature(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg2) != 64) {
            return false
        };
        0x2::ed25519::ed25519_verify(arg2, arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

