module 0x7009ae82f365ee92f05c94a10184fbb5a4732a514ffa29147007c5c63e51ef4f::suirk {
    struct SUIRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRK>(arg0, 6, b"SUIRK", b"Shark SUI", x"24536861726b206f6e2024537569204c697665206f6e204d6f766550756d70204f6666696369616c2067726f757068747470733a2f2f742e6d652f537569536861726b436f696e2020537461727420536861726b2074696d65200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/132846b8237a4927d39e16d0a2e0788a_c68b2d8b02.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

