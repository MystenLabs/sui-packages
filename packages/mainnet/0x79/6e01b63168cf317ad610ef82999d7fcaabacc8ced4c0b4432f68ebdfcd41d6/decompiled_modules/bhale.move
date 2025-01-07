module 0x796e01b63168cf317ad610ef82999d7fcaabacc8ced4c0b4432f68ebdfcd41d6::bhale {
    struct BHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHALE>(arg0, 6, b"BHALE", b"Bhale", x"4268616c65202d206120677265617420626c7565207768616c652077686f20676f74206c6f737420696e2074686520736561206f66205375692e2048656c70204268616c652066696e6420686f6d65210a4a6f696e2054656c656772616d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hjj_12520fe856.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

