module 0x785dca70c1e9a17a979278a03e79cc564d30727e6bc7421eaa6557e1ef30f140::mebe {
    struct MEBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEBE>(arg0, 9, b"MEBE", b"MACELBEN ", b"A meme coin on SUI blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aca33254-51d7-4754-ad45-434fa7e25d8b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

