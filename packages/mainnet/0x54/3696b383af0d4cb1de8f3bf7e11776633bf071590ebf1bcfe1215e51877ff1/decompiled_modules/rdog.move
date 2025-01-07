module 0x543696b383af0d4cb1de8f3bf7e11776633bf071590ebf1bcfe1215e51877ff1::rdog {
    struct RDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDOG>(arg0, 6, b"Rdog", b"Random Dog ($Rdog)", b"Random Dog just come to sui, go to our website just refresh to find the dog you like, we are great meme coin on sui .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_ragdoll_cat_d6ee9bc3e0.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

