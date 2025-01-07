module 0x7d9948ccf67c85f5194c3c9d6315dcf4f8b8ca8097d17ea042f97eab9fb60589::aibon {
    struct AIBON has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIBON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIBON>(arg0, 9, b"AIBON", b"Lem Aibon", b"Its just a glue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4da5c349-8286-4fae-be16-683fe04c87d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIBON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIBON>>(v1);
    }

    // decompiled from Move bytecode v6
}

