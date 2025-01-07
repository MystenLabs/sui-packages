module 0xf6bc5e424761a76ac2da0e161eee8b6e0546763e065172d002907b45f762669e::wormy {
    struct WORMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORMY>(arg0, 6, b"Wormy", b"Worm", b" worm worm worm worm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6766_9fe231aa54.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

