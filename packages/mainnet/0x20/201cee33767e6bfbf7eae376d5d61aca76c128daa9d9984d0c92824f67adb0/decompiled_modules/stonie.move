module 0x20201cee33767e6bfbf7eae376d5d61aca76c128daa9d9984d0c92824f67adb0::stonie {
    struct STONIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONIE>(arg0, 6, b"STONIE", b"Sui Stonie", b"Meet Stonie, the highest member of the group. He was so stoned that he missed the invitation to join the Boys' Club.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/stonie_2d301d90c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

