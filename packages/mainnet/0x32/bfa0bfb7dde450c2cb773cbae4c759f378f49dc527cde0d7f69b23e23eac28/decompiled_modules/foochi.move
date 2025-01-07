module 0x32bfa0bfb7dde450c2cb773cbae4c759f378f49dc527cde0d7f69b23e23eac28::foochi {
    struct FOOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOOCHI>(arg0, 6, b"FOOCHI", b"SUIFoochi", b"Foochi is the fluffiest, most colorful coin on Solana, bringing joy and doodle vibes to your wallet. $FOOPO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S3ei_E26_Q_400x400_b06f1a4c00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOOCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOOCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

