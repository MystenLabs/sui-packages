module 0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::envelope {
    struct SlippagePoint has copy, drop, store {
        offset_ms: u32,
        slippage_bps: u16,
    }

    struct QuoteLayer has copy, drop, store {
        price: u128,
        depth: u64,
        filled: u64,
    }

    struct QuoteLayerV2 has copy, drop, store {
        price: u128,
        depth: u64,
        filled: u64,
    }

    struct TimeSlippagePoint has copy, drop, store {
        offset_ms: u32,
        slippage_bps: u16,
    }

    struct FillSlippagePoint has copy, drop, store {
        amount_base: u64,
        start_ms: u32,
        slippage_bps: u16,
    }

    struct SlippageCurveV2 has copy, drop, store {
        time_points: vector<TimeSlippagePoint>,
        fill_points: vector<FillSlippagePoint>,
        max_total_slippage_bps: u16,
    }

    struct SignedQuote has copy, drop, store {
        domain: vector<u8>,
        mm_object_id: 0x2::object::ID,
        pool_object_id: 0x2::object::ID,
        a2b: bool,
        layers: vector<QuoteLayer>,
        slippage: SlippagePoint,
        signed_at_ms: u64,
        sig_expiry_ms: u64,
        fill_or_kill: bool,
        min_fill: u64,
    }

    struct SignedQuoteV2 has copy, drop, store {
        domain: vector<u8>,
        mm_object_id: 0x2::object::ID,
        pool_object_id: 0x2::object::ID,
        a2b: bool,
        layers: vector<QuoteLayerV2>,
        slippage: SlippageCurveV2,
        signed_at_ms: u64,
        sig_expiry_ms: u64,
        fill_or_kill: bool,
        min_fill: u64,
        signer_policy_version: u64,
        inventory_version: u64,
    }

    struct RebalanceQuote has copy, drop, store {
        domain: vector<u8>,
        coin_in: 0x1::string::String,
        coin_out: 0x1::string::String,
        amount_in: u64,
        amount_out: u64,
        issued_at_ms: u64,
        expiry_ms: u64,
        signer_version: u64,
    }

    public fun add_layer_filled(arg0: &mut QuoteLayer, arg1: u64) : u64 {
        arg0.filled = arg0.filled + arg1;
        arg0.filled
    }

    public fun add_layer_v2_filled(arg0: &mut QuoteLayerV2, arg1: u64) : u64 {
        arg0.filled = arg0.filled + arg1;
        arg0.filled
    }

    public fun compute_quote_hash(arg0: &vector<u8>) : vector<u8> {
        0x2::hash::blake2b256(arg0)
    }

    public fun decode_rebalance_quote(arg0: vector<u8>) : RebalanceQuote {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(v1 == x"43657475732d5051462d5375692d526562616c616e63652d7631000000000000", 1);
        RebalanceQuote{
            domain         : v1,
            coin_in        : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
            coin_out       : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
            amount_in      : 0x2::bcs::peel_u64(&mut v0),
            amount_out     : 0x2::bcs::peel_u64(&mut v0),
            issued_at_ms   : 0x2::bcs::peel_u64(&mut v0),
            expiry_ms      : 0x2::bcs::peel_u64(&mut v0),
            signer_version : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public fun decode_signed_quote(arg0: vector<u8>) : SignedQuote {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(v1 == x"43657475732d5051462d5375692d4f72646572426f6f6b2d7631000000000000", 1);
        let v2 = &mut v0;
        let v3 = SlippagePoint{
            offset_ms    : 0x2::bcs::peel_u32(&mut v0),
            slippage_bps : 0x2::bcs::peel_u16(&mut v0),
        };
        SignedQuote{
            domain         : v1,
            mm_object_id   : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            pool_object_id : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            a2b            : 0x2::bcs::peel_bool(&mut v0),
            layers         : peel_quote_layers(v2),
            slippage       : v3,
            signed_at_ms   : 0x2::bcs::peel_u64(&mut v0),
            sig_expiry_ms  : 0x2::bcs::peel_u64(&mut v0),
            fill_or_kill   : 0x2::bcs::peel_bool(&mut v0),
            min_fill       : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public fun decode_signed_quote_v2(arg0: vector<u8>) : SignedQuoteV2 {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::peel_vec_u8(&mut v0);
        assert!(v1 == x"43657475732d5051462d5375692d4f72646572426f6f6b2d7632000000000000", 1);
        let v2 = &mut v0;
        let v3 = &mut v0;
        SignedQuoteV2{
            domain                : v1,
            mm_object_id          : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            pool_object_id        : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            a2b                   : 0x2::bcs::peel_bool(&mut v0),
            layers                : peel_quote_layers_v2(v2),
            slippage              : peel_slippage_curve_v2(v3),
            signed_at_ms          : 0x2::bcs::peel_u64(&mut v0),
            sig_expiry_ms         : 0x2::bcs::peel_u64(&mut v0),
            fill_or_kill          : 0x2::bcs::peel_bool(&mut v0),
            min_fill              : 0x2::bcs::peel_u64(&mut v0),
            signer_policy_version : 0x2::bcs::peel_u64(&mut v0),
            inventory_version     : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public fun domain_orderbook() : vector<u8> {
        x"43657475732d5051462d5375692d4f72646572426f6f6b2d7631000000000000"
    }

    public fun domain_orderbook_v2() : vector<u8> {
        x"43657475732d5051462d5375692d4f72646572426f6f6b2d7632000000000000"
    }

    public fun domain_pqf_rebalance_quote() : vector<u8> {
        x"43657475732d5051462d5375692d526562616c616e63652d7631000000000000"
    }

    public fun envelope_a2b(arg0: &SignedQuote) : bool {
        arg0.a2b
    }

    public fun envelope_fill_or_kill(arg0: &SignedQuote) : bool {
        arg0.fill_or_kill
    }

    public fun envelope_layers(arg0: &SignedQuote) : &vector<QuoteLayer> {
        &arg0.layers
    }

    public fun envelope_min_fill(arg0: &SignedQuote) : u64 {
        arg0.min_fill
    }

    public fun envelope_mm_object_id(arg0: &SignedQuote) : 0x2::object::ID {
        arg0.mm_object_id
    }

    public fun envelope_pool_object_id(arg0: &SignedQuote) : 0x2::object::ID {
        arg0.pool_object_id
    }

    public fun envelope_sig_expiry_ms(arg0: &SignedQuote) : u64 {
        arg0.sig_expiry_ms
    }

    public fun envelope_signed_at_ms(arg0: &SignedQuote) : u64 {
        arg0.signed_at_ms
    }

    public fun envelope_slippage(arg0: &SignedQuote) : &SlippagePoint {
        &arg0.slippage
    }

    public fun envelope_v2_a2b(arg0: &SignedQuoteV2) : bool {
        arg0.a2b
    }

    public fun envelope_v2_fill_or_kill(arg0: &SignedQuoteV2) : bool {
        arg0.fill_or_kill
    }

    public fun envelope_v2_inventory_version(arg0: &SignedQuoteV2) : u64 {
        arg0.inventory_version
    }

    public fun envelope_v2_layers(arg0: &SignedQuoteV2) : &vector<QuoteLayerV2> {
        &arg0.layers
    }

    public fun envelope_v2_min_fill(arg0: &SignedQuoteV2) : u64 {
        arg0.min_fill
    }

    public fun envelope_v2_mm_object_id(arg0: &SignedQuoteV2) : 0x2::object::ID {
        arg0.mm_object_id
    }

    public fun envelope_v2_pool_object_id(arg0: &SignedQuoteV2) : 0x2::object::ID {
        arg0.pool_object_id
    }

    public fun envelope_v2_sig_expiry_ms(arg0: &SignedQuoteV2) : u64 {
        arg0.sig_expiry_ms
    }

    public fun envelope_v2_signed_at_ms(arg0: &SignedQuoteV2) : u64 {
        arg0.signed_at_ms
    }

    public fun envelope_v2_signer_policy_version(arg0: &SignedQuoteV2) : u64 {
        arg0.signer_policy_version
    }

    public fun envelope_v2_slippage(arg0: &SignedQuoteV2) : &SlippageCurveV2 {
        &arg0.slippage
    }

    public fun fill_point_amount_base(arg0: &FillSlippagePoint) : u64 {
        arg0.amount_base
    }

    public fun fill_point_slippage_bps(arg0: &FillSlippagePoint) : u16 {
        arg0.slippage_bps
    }

    public fun fill_point_start_ms(arg0: &FillSlippagePoint) : u32 {
        arg0.start_ms
    }

    public fun layer_depth(arg0: &QuoteLayer) : u64 {
        arg0.depth
    }

    public fun layer_filled(arg0: &QuoteLayer) : u64 {
        arg0.filled
    }

    public fun layer_price(arg0: &QuoteLayer) : u128 {
        arg0.price
    }

    public fun layer_v2_depth(arg0: &QuoteLayerV2) : u64 {
        arg0.depth
    }

    public fun layer_v2_filled(arg0: &QuoteLayerV2) : u64 {
        arg0.filled
    }

    public fun layer_v2_price(arg0: &QuoteLayerV2) : u128 {
        arg0.price
    }

    public fun new_fill_slippage_point(arg0: u64, arg1: u32, arg2: u16) : FillSlippagePoint {
        FillSlippagePoint{
            amount_base  : arg0,
            start_ms     : arg1,
            slippage_bps : arg2,
        }
    }

    public fun new_layer(arg0: u128, arg1: u64, arg2: u64) : QuoteLayer {
        QuoteLayer{
            price  : arg0,
            depth  : arg1,
            filled : arg2,
        }
    }

    public fun new_layer_v2(arg0: u128, arg1: u64, arg2: u64) : QuoteLayerV2 {
        QuoteLayerV2{
            price  : arg0,
            depth  : arg1,
            filled : arg2,
        }
    }

    public fun new_slippage_curve_v2(arg0: vector<TimeSlippagePoint>, arg1: vector<FillSlippagePoint>, arg2: u16) : SlippageCurveV2 {
        SlippageCurveV2{
            time_points            : arg0,
            fill_points            : arg1,
            max_total_slippage_bps : arg2,
        }
    }

    public fun new_slippage_point(arg0: u32, arg1: u16) : SlippagePoint {
        SlippagePoint{
            offset_ms    : arg0,
            slippage_bps : arg1,
        }
    }

    public fun new_time_slippage_point(arg0: u32, arg1: u16) : TimeSlippagePoint {
        TimeSlippagePoint{
            offset_ms    : arg0,
            slippage_bps : arg1,
        }
    }

    fun peel_fill_slippage_points(arg0: &mut 0x2::bcs::BCS) : vector<FillSlippagePoint> {
        let v0 = 0x1::vector::empty<FillSlippagePoint>();
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_vec_length(arg0)) {
            let v2 = FillSlippagePoint{
                amount_base  : 0x2::bcs::peel_u64(arg0),
                start_ms     : 0x2::bcs::peel_u32(arg0),
                slippage_bps : 0x2::bcs::peel_u16(arg0),
            };
            0x1::vector::push_back<FillSlippagePoint>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun peel_quote_layers(arg0: &mut 0x2::bcs::BCS) : vector<QuoteLayer> {
        let v0 = 0x1::vector::empty<QuoteLayer>();
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_vec_length(arg0)) {
            let v2 = QuoteLayer{
                price  : 0x2::bcs::peel_u128(arg0),
                depth  : 0x2::bcs::peel_u64(arg0),
                filled : 0x2::bcs::peel_u64(arg0),
            };
            0x1::vector::push_back<QuoteLayer>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun peel_quote_layers_v2(arg0: &mut 0x2::bcs::BCS) : vector<QuoteLayerV2> {
        let v0 = 0x1::vector::empty<QuoteLayerV2>();
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_vec_length(arg0)) {
            let v2 = QuoteLayerV2{
                price  : 0x2::bcs::peel_u128(arg0),
                depth  : 0x2::bcs::peel_u64(arg0),
                filled : 0x2::bcs::peel_u64(arg0),
            };
            0x1::vector::push_back<QuoteLayerV2>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun peel_slippage_curve_v2(arg0: &mut 0x2::bcs::BCS) : SlippageCurveV2 {
        let v0 = peel_time_slippage_points(arg0);
        let v1 = peel_fill_slippage_points(arg0);
        SlippageCurveV2{
            time_points            : v0,
            fill_points            : v1,
            max_total_slippage_bps : 0x2::bcs::peel_u16(arg0),
        }
    }

    fun peel_time_slippage_points(arg0: &mut 0x2::bcs::BCS) : vector<TimeSlippagePoint> {
        let v0 = 0x1::vector::empty<TimeSlippagePoint>();
        let v1 = 0;
        while (v1 < 0x2::bcs::peel_vec_length(arg0)) {
            let v2 = TimeSlippagePoint{
                offset_ms    : 0x2::bcs::peel_u32(arg0),
                slippage_bps : 0x2::bcs::peel_u16(arg0),
            };
            0x1::vector::push_back<TimeSlippagePoint>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun rebalance_quote_amount_in(arg0: &RebalanceQuote) : u64 {
        arg0.amount_in
    }

    public fun rebalance_quote_amount_out(arg0: &RebalanceQuote) : u64 {
        arg0.amount_out
    }

    public fun rebalance_quote_coin_in(arg0: &RebalanceQuote) : &0x1::string::String {
        &arg0.coin_in
    }

    public fun rebalance_quote_coin_out(arg0: &RebalanceQuote) : &0x1::string::String {
        &arg0.coin_out
    }

    public fun rebalance_quote_expiry_ms(arg0: &RebalanceQuote) : u64 {
        arg0.expiry_ms
    }

    public fun rebalance_quote_issued_at_ms(arg0: &RebalanceQuote) : u64 {
        arg0.issued_at_ms
    }

    public fun rebalance_quote_signer_version(arg0: &RebalanceQuote) : u64 {
        arg0.signer_version
    }

    public fun slippage_bps(arg0: &SlippagePoint) : u16 {
        arg0.slippage_bps
    }

    public fun slippage_offset_ms(arg0: &SlippagePoint) : u32 {
        arg0.offset_ms
    }

    public fun slippage_v2_fill_points(arg0: &SlippageCurveV2) : &vector<FillSlippagePoint> {
        &arg0.fill_points
    }

    public fun slippage_v2_max_total_slippage_bps(arg0: &SlippageCurveV2) : u16 {
        arg0.max_total_slippage_bps
    }

    public fun slippage_v2_time_points(arg0: &SlippageCurveV2) : &vector<TimeSlippagePoint> {
        &arg0.time_points
    }

    public fun time_point_offset_ms(arg0: &TimeSlippagePoint) : u32 {
        arg0.offset_ms
    }

    public fun time_point_slippage_bps(arg0: &TimeSlippagePoint) : u16 {
        arg0.slippage_bps
    }

    public fun unpack_envelope(arg0: SignedQuote) : (vector<QuoteLayer>, SlippagePoint, u64, u64, bool, u64) {
        let SignedQuote {
            domain         : _,
            mm_object_id   : _,
            pool_object_id : _,
            a2b            : _,
            layers         : v4,
            slippage       : v5,
            signed_at_ms   : v6,
            sig_expiry_ms  : v7,
            fill_or_kill   : v8,
            min_fill       : v9,
        } = arg0;
        (v4, v5, v6, v7, v8, v9)
    }

    public fun unpack_envelope_v2(arg0: SignedQuoteV2) : (vector<QuoteLayerV2>, SlippageCurveV2, u64, u64, bool, u64, u64, u64) {
        let SignedQuoteV2 {
            domain                : _,
            mm_object_id          : _,
            pool_object_id        : _,
            a2b                   : _,
            layers                : v4,
            slippage              : v5,
            signed_at_ms          : v6,
            sig_expiry_ms         : v7,
            fill_or_kill          : v8,
            min_fill              : v9,
            signer_policy_version : v10,
            inventory_version     : v11,
        } = arg0;
        (v4, v5, v6, v7, v8, v9, v10, v11)
    }

    public fun verify_message(arg0: &vector<u8>, arg1: &vector<u8>) : address {
        assert!(0x1::vector::length<u8>(arg1) == 96, 2);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg1, v2));
            v2 = v2 + 1;
        };
        while (v2 < 96) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg1, v2));
            v2 = v2 + 1;
        };
        assert!(0x2::ed25519::ed25519_verify(&v1, &v0, arg0), 3);
        let v3 = 0x1::vector::singleton<u8>(0);
        0x1::vector::append<u8>(&mut v3, v0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v3))
    }

    public fun verify_rebalance_quote_signature(arg0: &vector<u8>, arg1: &vector<u8>) : address {
        let v0 = x"43657475732d5051462d5375692d526562616c616e63652d7631000000000000";
        0x1::vector::append<u8>(&mut v0, *arg0);
        verify_message(&v0, arg1)
    }

    public fun verify_signature(arg0: &vector<u8>, arg1: &vector<u8>) : address {
        let v0 = x"43657475732d5051462d5375692d4f72646572426f6f6b2d7631000000000000";
        0x1::vector::append<u8>(&mut v0, *arg0);
        verify_message(&v0, arg1)
    }

    public fun verify_signature_v2(arg0: &vector<u8>, arg1: &vector<u8>) : address {
        let v0 = x"43657475732d5051462d5375692d4f72646572426f6f6b2d7632000000000000";
        0x1::vector::append<u8>(&mut v0, *arg0);
        verify_message(&v0, arg1)
    }

    // decompiled from Move bytecode v7
}

