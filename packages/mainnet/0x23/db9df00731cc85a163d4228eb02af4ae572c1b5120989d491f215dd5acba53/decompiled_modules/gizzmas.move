module 0x23db9df00731cc85a163d4228eb02af4ae572c1b5120989d491f215dd5acba53::gizzmas {
    struct GIZZMAS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GIZZMAS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GIZZMAS>>(0x2::coin::mint<GIZZMAS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GIZZMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9MmuDBQCbGGYLGKGajNpfwWBja1sXhxmPgbLowMFpump.png?size=lg&key=9693ca                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GIZZMAS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GIZZMAS ")))), trim_right(b"Gizzmas                         "), trim_right(b"Gizzmas is all about embracing the chaos of the holidays. Its the joy, the mess, and the unexpected moments that make Christmas so much fun. From Gizmo in a Santa hat to gremlins wrecking everything, Gizzmas is here to make your holiday a little wilder.                                                                   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIZZMAS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GIZZMAS>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GIZZMAS>>(0x2::coin::mint<GIZZMAS>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

