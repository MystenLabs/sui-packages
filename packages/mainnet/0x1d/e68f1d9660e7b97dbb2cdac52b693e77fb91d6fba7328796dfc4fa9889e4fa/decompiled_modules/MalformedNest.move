module 0x1de68f1d9660e7b97dbb2cdac52b693e77fb91d6fba7328796dfc4fa9889e4fa::MalformedNest {
    struct MALFORMEDNEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MALFORMEDNEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MALFORMEDNEST>(arg0, 0, b"COS", b"Malformed Nest", b"The Corruption spreads, nesting in once-Divine lands... It has a mind of its own, does it not?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Malformed_Nest.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MALFORMEDNEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MALFORMEDNEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

