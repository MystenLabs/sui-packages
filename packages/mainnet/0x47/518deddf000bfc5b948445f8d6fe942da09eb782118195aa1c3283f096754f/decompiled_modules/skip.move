module 0x47518deddf000bfc5b948445f8d6fe942da09eb782118195aa1c3283f096754f::skip {
    struct SKIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIP>(arg0, 6, b"SKIP", b"Skippy the Seahorse", b"In the Deep Coral reefs of the Azure Sui, lived a small seahorse named Skippy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003617_afe4f5d9ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

