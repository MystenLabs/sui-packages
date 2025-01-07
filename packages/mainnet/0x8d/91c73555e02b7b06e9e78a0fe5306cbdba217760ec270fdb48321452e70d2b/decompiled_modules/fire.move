module 0x8d91c73555e02b7b06e9e78a0fe5306cbdba217760ec270fdb48321452e70d2b::fire {
    struct FIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRE>(arg0, 9, b"FIRE", b"Duckychain", b"This is all we want right now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31ab65be-376c-4e9c-8084-7feca0d94d79.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

