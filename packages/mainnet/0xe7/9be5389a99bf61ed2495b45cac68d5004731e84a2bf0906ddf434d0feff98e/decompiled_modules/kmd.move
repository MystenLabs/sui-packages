module 0xe79be5389a99bf61ed2495b45cac68d5004731e84a2bf0906ddf434d0feff98e::kmd {
    struct KMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: KMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KMD>(arg0, 6, b"KMD", b"Komodo", b"Last dragon in the world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_a70a3f5052.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KMD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KMD>>(v1);
    }

    // decompiled from Move bytecode v6
}

