module 0x30d6a77c0c6ea1b58b6ef075589ac50ec573b622a48a82e544066287f1d6738b::GatherersBaskets {
    struct GATHERERSBASKETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATHERERSBASKETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATHERERSBASKETS>(arg0, 0, b"COS", b"Gatherer's Baskets", b"The guests want more... more... always more...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Gatherer's_Baskets.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GATHERERSBASKETS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATHERERSBASKETS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

