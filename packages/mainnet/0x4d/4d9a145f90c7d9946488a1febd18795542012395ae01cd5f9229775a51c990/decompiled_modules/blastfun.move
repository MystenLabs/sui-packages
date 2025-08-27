module 0x4d4d9a145f90c7d9946488a1febd18795542012395ae01cd5f9229775a51c990::blastfun {
    struct BLASTFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLASTFUN>(arg0, 9, b"blastfun", b"blastfuncharac", b"blastfuncharacteristics", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLASTFUN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLASTFUN>>(v2, @0x4214f3746036a6dfdbabc23b04deab00ecc63014e9f1ae660614441386e5732e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLASTFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

