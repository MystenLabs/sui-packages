module 0xe6959593ea08de37e9fdee0cebce36cf6853e02461be92e693ef3225b8f6af06::purrsuit {
    struct PURRSUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURRSUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURRSUIT>(arg0, 6, b"PURRSUIT", b"PURRRSUIT", b"Purrsuit on the purrsuit of world domination. Sui's cold blooded killer and protector of the based. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/94ooyb_eccf0ce4ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURRSUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURRSUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

