module 0x90762775d35915e4c9f44f687bfbe7dd559ce9683b057cb3d66f0a692ce7381::b_greengem {
    struct B_GREENGEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_GREENGEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_GREENGEM>(arg0, 9, b"bGREENGEM", b"bToken GREENGEM", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_GREENGEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_GREENGEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

