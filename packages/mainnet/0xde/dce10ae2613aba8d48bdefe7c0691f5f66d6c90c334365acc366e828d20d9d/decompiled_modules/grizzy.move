module 0xdedce10ae2613aba8d48bdefe7c0691f5f66d6c90c334365acc366e828d20d9d::grizzy {
    struct GRIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRIZZY>(arg0, 6, b"GRIZZY", b"Grizzy Bear", b"$GRIZZY just wants to be the next good thing. Simple. Fun. Chill. Zero overpromises. Just beach, breeze, and believers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000091494_8a6b9efc80.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRIZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

