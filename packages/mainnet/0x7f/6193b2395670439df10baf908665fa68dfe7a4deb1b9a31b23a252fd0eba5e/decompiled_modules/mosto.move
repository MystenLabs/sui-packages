module 0x7f6193b2395670439df10baf908665fa68dfe7a4deb1b9a31b23a252fd0eba5e::mosto {
    struct MOSTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSTO>(arg0, 6, b"MOSTO", b"Mostopapi", b"Meme of the devil Mostopapi. I eat rice with a spoon not a fork.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732239643234.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOSTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

