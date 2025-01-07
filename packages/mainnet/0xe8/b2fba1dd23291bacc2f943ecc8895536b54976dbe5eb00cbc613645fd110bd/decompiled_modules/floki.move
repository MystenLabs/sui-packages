module 0xe8b2fba1dd23291bacc2f943ecc8895536b54976dbe5eb00cbc613645fd110bd::floki {
    struct FLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKI>(arg0, 6, b"Floki", b"Floki on Sui", b"Floki is a community-based meme token surrounding the iconic meme Floki the dog. Floki aims to leverage the power of such an iconic meme to become the most memorable memecoin in existence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000272_6d9c087722.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

