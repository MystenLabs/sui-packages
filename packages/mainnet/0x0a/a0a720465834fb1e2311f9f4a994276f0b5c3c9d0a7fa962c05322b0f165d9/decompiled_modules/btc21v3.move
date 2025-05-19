module 0xaa0a720465834fb1e2311f9f4a994276f0b5c3c9d0a7fa962c05322b0f165d9::btc21v3 {
    struct BTC21V3 has drop {
        dummy_field: bool,
    }

    struct BTC21Treasury has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<BTC21V3>,
        metadata: 0x2::coin::CoinMetadata<BTC21V3>,
    }

    fun init(arg0: BTC21V3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC21V3>(arg0, 9, b"BTC21NEW", b"BTC21NEW", b"BTC21 official coin v3", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = BTC21Treasury{
            id       : 0x2::object::new(arg1),
            treasury : v0,
            metadata : v1,
        };
        0x2::coin::mint_and_transfer<BTC21V3>(&mut v2.treasury, 11130000000, @0x42216264b95739e181feb2fac36e72a02971271e846b9a56dbada2fdf0addc9b, arg1);
        0x2::coin::mint_and_transfer<BTC21V3>(&mut v2.treasury, 2520000000, @0xe3b920a033d2bc2ea8c52391e9096c1e8d755e3ad2fa74ecfd6402df606118cd, arg1);
        0x2::coin::mint_and_transfer<BTC21V3>(&mut v2.treasury, 1050000000, @0x54593d347979399ee5ceda84e806c75abd08fb1872b8ecc86f6d77d1683b5931, arg1);
        0x2::coin::mint_and_transfer<BTC21V3>(&mut v2.treasury, 6300000000, @0xbcfa3fa91f6d5dca36f84dceb00ac524363280b0a49c1a200ac44dc719eb036a, arg1);
        0x2::transfer::share_object<BTC21Treasury>(v2);
    }

    // decompiled from Move bytecode v6
}

