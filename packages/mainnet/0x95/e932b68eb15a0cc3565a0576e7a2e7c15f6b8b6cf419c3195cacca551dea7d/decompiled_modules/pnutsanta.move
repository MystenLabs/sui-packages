module 0x95e932b68eb15a0cc3565a0576e7a2e7c15f6b8b6cf419c3195cacca551dea7d::pnutsanta {
    struct PNUTSANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUTSANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUTSANTA>(arg0, 6, b"PNUTSANTA", b"Peanut Santa", b"Peanut Santa is an adorable squirrel dressed as Santa, spreading joy and festive cheer! With a playful and cheerful spirit, Peanut brings laughter and happiness wherever he goes, making every day feel like a holiday season.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gifpnut_e5128fa5b9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTSANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUTSANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

