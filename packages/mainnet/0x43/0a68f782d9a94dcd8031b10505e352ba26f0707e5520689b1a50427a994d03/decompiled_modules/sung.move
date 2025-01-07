module 0x430a68f782d9a94dcd8031b10505e352ba26f0707e5520689b1a50427a994d03::sung {
    struct SUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNG>(arg0, 9, b"SUNG", b"SUNEAGLE", b"The significant rise of cryptocurrency in the crypto wolrd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4a4aed54-d4b9-4a47-a4ad-3c9398671f0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

