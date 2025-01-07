module 0x59aa66e46caef4b93dba1ea9ce723c27bd187dd514b6599ae4f25e6ab8a4b69a::suina {
    struct SUINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINA>(arg0, 6, b"SUINA", b"Republic of Suina", b"Republic of Suina official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suina_8b96f181a1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

