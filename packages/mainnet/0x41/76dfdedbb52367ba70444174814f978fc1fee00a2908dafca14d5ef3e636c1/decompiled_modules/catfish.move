module 0x4176dfdedbb52367ba70444174814f978fc1fee00a2908dafca14d5ef3e636c1::catfish {
    struct CATFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATFISH>(arg0, 6, b"CATFISH", b"CatFish", b"CatFish is your beacon in the fog of finance, a testament to the joy of the unexpected. Because in the end, isn't life too short for boring investments?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cat_Fish_d747a7b270.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

