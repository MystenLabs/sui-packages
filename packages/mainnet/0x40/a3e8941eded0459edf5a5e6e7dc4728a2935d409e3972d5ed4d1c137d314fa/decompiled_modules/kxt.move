module 0x40a3e8941eded0459edf5a5e6e7dc4728a2935d409e3972d5ed4d1c137d314fa::kxt {
    struct KXT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KXT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KXT>(arg0, 6, b"KXT", b"kamalaxtrump", b"kamala x trump is now token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_1_7b73980f70.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KXT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KXT>>(v1);
    }

    // decompiled from Move bytecode v6
}

