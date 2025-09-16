module 0x4c9b1b4dafb98d7fd05d58923ce751931486e85cd0d9f8d1ff8339a5ac31c612::elmo {
    struct ELMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELMO>(arg0, 6, b"Elmo", b"Elmo on sui", b"The chaos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5617_15f7576371.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

