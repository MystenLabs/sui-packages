module 0xf3c4aaf7ee22d39427824e9452db9fdab01af8b5a1c7163325efe1888b3930d6::extrump {
    struct EXTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXTRUMP>(arg0, 9, b"EXTRUMP", b"ElonTrump", b"Meme about Elon and Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35028320-51b4-4eb9-8922-60ed70416032.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

