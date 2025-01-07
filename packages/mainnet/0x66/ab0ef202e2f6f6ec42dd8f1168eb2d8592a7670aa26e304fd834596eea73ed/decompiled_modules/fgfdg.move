module 0x66ab0ef202e2f6f6ec42dd8f1168eb2d8592a7670aa26e304fd834596eea73ed::fgfdg {
    struct FGFDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGFDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGFDG>(arg0, 6, b"Fgfdg", b"fasdfa", b"afdsfa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_68180088cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGFDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FGFDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

