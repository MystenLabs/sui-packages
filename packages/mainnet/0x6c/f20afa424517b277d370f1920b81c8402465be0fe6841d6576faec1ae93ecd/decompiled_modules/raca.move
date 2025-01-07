module 0x6cf20afa424517b277d370f1920b81c8402465be0fe6841d6576faec1ae93ecd::raca {
    struct RACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACA>(arg0, 9, b"RACA", b"Radiocaca", b"GameFi-Metaverse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a541625-aeb9-4c53-9f77-77b9285a0c82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RACA>>(v1);
    }

    // decompiled from Move bytecode v6
}

