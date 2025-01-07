module 0xd77ef0c0aa6b0974da1174486a140a27a50279bcefc62a81c40d69a03d09cdd::fesh {
    struct FESH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FESH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FESH>(arg0, 6, b"FESH", b"Fesh", b"Just a fesh for now...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009134_a8c2a6ad05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FESH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FESH>>(v1);
    }

    // decompiled from Move bytecode v6
}

