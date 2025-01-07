module 0x874883ba359d6be3c54e5764207efd842fc35fd25939b9a2f9baffad1f1226d4::michi {
    struct MICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICHI>(arg0, 6, b"MICHI", b"MICHI CAT", b"The most memeable cat on the Internet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Michi_7bf2dffa5f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MICHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

