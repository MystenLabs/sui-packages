module 0xd744621333fd7cca3d01047cbcd943dd5a8124c1442cdc3a87a020c1a4dfd786::stama {
    struct STAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAMA>(arg0, 6, b"STAMA", b"Suitama", b"SUITAMA, the heroic alter ego of Evan Cheng and the first superhero of the Sui Chain, is finally here to be the next big meme token in the space!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_16_47_55_80147b205b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

