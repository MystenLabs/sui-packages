module 0x60f4f06f0c924aa9bf04331c9d61ce98d0a6954eea0354e5ee3fab051d6d0417::suier {
    struct SUIER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIER>(arg0, 6, b"SUIER", b"SuiTiger", b"Join the new revolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_23_10_19_0d1f6ea046.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIER>>(v1);
    }

    // decompiled from Move bytecode v6
}

