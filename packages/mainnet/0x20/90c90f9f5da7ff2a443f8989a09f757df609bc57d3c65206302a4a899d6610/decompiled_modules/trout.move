module 0x2090c90f9f5da7ff2a443f8989a09f757df609bc57d3c65206302a4a899d6610::trout {
    struct TROUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROUT>(arg0, 6, b"TROUT", b"Tommy the Trout", b"He loves to sing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_28_111047_3b74066f01.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

