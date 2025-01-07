module 0x8c269d7efd842018d67915e0fcb9917d3db955cb87e85db20a6a52872e5bcbaf::lumo {
    struct LUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUMO>(arg0, 6, b"LUMO", b"Lumo Coin", b"Follow $Lumo to build a new Home", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048031_a996d4dbae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

