module 0xb6a6dcd57c8f3d684571efdb17880a3147fe7978d3c2162ef08edf502b6e0798::hdog {
    struct HDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDOG>(arg0, 6, b"Hdog", b"Halloween Dog", x"48616c6c6f7765656e20697320636f6d696e6720736f6f6e2e207c2068444f472077696c6c206265206c61756e63686564206f6e200a405375696e6574776f726b20202d2058206163636f756e74203a204068646f676f6e73756920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EGERGERGER_f51d816287.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

