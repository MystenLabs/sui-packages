module 0x53e0a7e9e94e24fc32a8c5d1bd02192c8ca63ada6846b0ad71dc2323ef643cf4::snub {
    struct SNUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUB>(arg0, 6, b"SNUB", b"Snub", b"Snub on Sui he cute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/snub_e5ada4d871.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

