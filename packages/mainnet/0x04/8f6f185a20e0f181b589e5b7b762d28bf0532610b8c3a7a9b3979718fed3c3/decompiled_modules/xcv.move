module 0x48f6f185a20e0f181b589e5b7b762d28bf0532610b8c3a7a9b3979718fed3c3::xcv {
    struct XCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: XCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XCV>(arg0, 6, b"XCV", b"cfvxcv", b"cfvxcvcfvxcvcfvxcv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieyxrbdxqycwrgmlodm2egn7agzjukio4t4wfqph7sxowwkdng4ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XCV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

