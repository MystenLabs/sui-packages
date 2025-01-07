module 0x93580bba368ab26983fa1ed088ec222104c04c105663df7b869e5784cc2c1952::np {
    struct NP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NP>(arg0, 6, b"NP", b"Nerdpepe", b"your favorite Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nerdpepe_7427d77983.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NP>>(v1);
    }

    // decompiled from Move bytecode v6
}

