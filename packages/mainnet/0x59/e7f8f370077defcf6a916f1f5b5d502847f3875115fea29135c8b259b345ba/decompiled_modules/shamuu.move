module 0x59e7f8f370077defcf6a916f1f5b5d502847f3875115fea29135c8b259b345ba::shamuu {
    struct SHAMUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAMUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAMUU>(arg0, 6, b"SHAMUU", b"Shamu", b"https://t.me/shamusui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_21_56_36_3a520904ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAMUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAMUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

