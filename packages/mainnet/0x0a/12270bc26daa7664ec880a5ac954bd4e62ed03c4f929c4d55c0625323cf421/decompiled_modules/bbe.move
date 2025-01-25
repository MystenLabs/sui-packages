module 0xa12270bc26daa7664ec880a5ac954bd4e62ed03c4f929c4d55c0625323cf421::bbe {
    struct BBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBE>(arg0, 6, b"Bbe", b"Heh", b"Bsns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A18403_E3_B57_E_40_F1_BFE_4_8_F051_E780522_cef9566de9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

