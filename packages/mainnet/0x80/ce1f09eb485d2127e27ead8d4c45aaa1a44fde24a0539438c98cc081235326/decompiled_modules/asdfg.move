module 0x80ce1f09eb485d2127e27ead8d4c45aaa1a44fde24a0539438c98cc081235326::asdfg {
    struct ASDFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDFG>(arg0, 6, b"ASDFG", b"ASDFGH", b"WTF IS THIS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_18_08_38_630102c669.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASDFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

