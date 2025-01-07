module 0x1ca0e48b183033f2a374b47a8a56c07002837fb8c3afdd252eb2bd7ea824c66::bunnydog {
    struct BUNNYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNYDOG>(arg0, 6, b"Bunnydog", b"first bunnydog", b"first bunnydog on turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730996360720.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUNNYDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNYDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

