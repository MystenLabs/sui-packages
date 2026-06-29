module 0xbf7915f9fb7f3ccd2df1058c53e6869bdaef64b569ba0c89cfc1fbf43a7f87df::envelope {
    struct SlippagePoint has copy, drop, store {
        offset_ms: u32,
        slippage_bps: u16,
    }

    struct QuoteLayer has copy, drop, store {
        price: u128,
        depth: u64,
        filled: u64,
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

    public fun add_layer_filled(arg0: &mut QuoteLayer, arg1: u64) : u64 {
        arg0.filled = arg0.filled + arg1;
        arg0.filled
    }

    public fun compute_quote_hash(arg0: &vector<u8>) : vector<u8> {
        0x2::hash::blake2b256(arg0)
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

    public fun domain_orderbook() : vector<u8> {
        x"43657475732d5051462d5375692d4f72646572426f6f6b2d7631000000000000"
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

    public fun layer_depth(arg0: &QuoteLayer) : u64 {
        arg0.depth
    }

    public fun layer_filled(arg0: &QuoteLayer) : u64 {
        arg0.filled
    }

    public fun layer_price(arg0: &QuoteLayer) : u128 {
        arg0.price
    }

    public fun new_layer(arg0: u128, arg1: u64, arg2: u64) : QuoteLayer {
        QuoteLayer{
            price  : arg0,
            depth  : arg1,
            filled : arg2,
        }
    }

    public fun new_slippage_point(arg0: u32, arg1: u16) : SlippagePoint {
        SlippagePoint{
            offset_ms    : arg0,
            slippage_bps : arg1,
        }
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

    public fun slippage_bps(arg0: &SlippagePoint) : u16 {
        arg0.slippage_bps
    }

    public fun slippage_offset_ms(arg0: &SlippagePoint) : u32 {
        arg0.offset_ms
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

    public fun verify_signature(arg0: &vector<u8>, arg1: &vector<u8>) : address {
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
        let v3 = x"43657475732d5051462d5375692d4f72646572426f6f6b2d7631000000000000";
        0x1::vector::append<u8>(&mut v3, *arg0);
        assert!(0x2::ed25519::ed25519_verify(&v1, &v0, &v3), 3);
        let v4 = 0x1::vector::singleton<u8>(0);
        0x1::vector::append<u8>(&mut v4, v0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v4))
    }

    // decompiled from Move bytecode v7
}

