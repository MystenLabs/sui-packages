module 0x2a6fa477c4434dfb5b5f307bf2c5bfdbde8b3c03ad47509f0cf6947ba8cae354::gme {
    struct GME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GME>(arg0, 6, b"GME", b"gme", x"24474d45206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730981096966.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

