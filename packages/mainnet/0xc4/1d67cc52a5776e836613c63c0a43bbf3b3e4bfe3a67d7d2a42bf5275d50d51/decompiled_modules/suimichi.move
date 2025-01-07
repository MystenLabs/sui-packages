module 0xc41d67cc52a5776e836613c63c0a43bbf3b3e4bfe3a67d7d2a42bf5275d50d51::suimichi {
    struct SUIMICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMICHI>(arg0, 6, b"SUIMICHI", b"Sui michi", b"The most memeable cat on SUI...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIMICHI_bd89d2976a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMICHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMICHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

