module 0xdecb150ed14d08d7dc55fe2d39930f853226123a5cad78602eb987ac53f9e074::suli {
    struct SULI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULI>(arg0, 6, b"Suli", b"Suli eyes", b"$Suli on Sui, a tortured soul, wanders the dark expanse of the SUI ecosystem. With hollow eyes and a maniacal grin, Suli embodies the frustrations and despair of navigating the unpredictable world of cryptocurrency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6001212942500086653_y_6bb990eb10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULI>>(v1);
    }

    // decompiled from Move bytecode v6
}

