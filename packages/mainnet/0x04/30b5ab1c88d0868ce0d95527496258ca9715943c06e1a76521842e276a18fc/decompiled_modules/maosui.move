module 0x430b5ab1c88d0868ce0d95527496258ca9715943c06e1a76521842e276a18fc::maosui {
    struct MAOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAOSUI>(arg0, 6, b"MAOSUI", b"Maosui", b"Meet the chinese cat of Sui! Literally the chinese translation of cat. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6321175301538823419_x_b2e8490b78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

