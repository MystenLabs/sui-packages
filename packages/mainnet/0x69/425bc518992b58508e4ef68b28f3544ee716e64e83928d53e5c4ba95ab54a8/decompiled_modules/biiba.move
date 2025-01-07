module 0x69425bc518992b58508e4ef68b28f3544ee716e64e83928d53e5c4ba95ab54a8::biiba {
    struct BIIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIIBA>(arg0, 9, b"BIIBA", b"Biib ", b"A community strategist meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14f4925f-7f26-473f-8857-2956aee9b556.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

