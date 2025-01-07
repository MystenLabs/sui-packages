module 0x59dd3d5cfded109807e8dc1d74ce765a681cf2119be51755d355f5599c0a3bd6::ohno {
    struct OHNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OHNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OHNO>(arg0, 9, b"OHNO", b"OHNO", b"Oh No!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cf.geekdo-images.com/camo/cba429883803dadea626df689cdbf3ddc0dc1bba/68747470733a2f2f692e696d6775722e636f6d2f456161485557462e6a7067")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OHNO>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OHNO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OHNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

