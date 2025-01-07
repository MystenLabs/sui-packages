module 0x12f08dd936c7c0cf99b6f0c4229df38ab3f9075424f3ad2170adf8dd5097574a::kncoin {
    struct KNCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNCOIN>(arg0, 9, b"KNCOIN", b"Knight ", b"trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f1ed8d5-f82b-4c5a-93f9-e193daab3849.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KNCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

