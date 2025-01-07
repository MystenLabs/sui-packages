module 0x253e1b0838fc4eb6069b124fd7b87d2de3b8fc82121052d559d66ba5f4cfeed7::aka {
    struct AKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKA>(arg0, 6, b"AKA", b"Akinia", b"Akinia from JP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/anko_3d_cartoon_narval0009_0d246e04fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

