module 0x900699c8a95a64747ec03c0ad16076dcf095efeaabd7217dbabc7a1e03faed4d::gtg {
    struct GTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTG>(arg0, 9, b"GTG", b"Goat", b"Cryptospace, we ready", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4f6c600-932f-41f5-a630-4d4a4f70e69b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTG>>(v1);
    }

    // decompiled from Move bytecode v6
}

