module 0x880255a4fe92ef4f85156ce23b3d8637fd968c899d157ef04007424a8126fee6::red {
    struct RED has drop {
        dummy_field: bool,
    }

    fun init(arg0: RED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RED>(arg0, 6, b"Red", b"Sui Red", b"Red Sui is the fiery heartbeat of the Sui chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sinvcdxbewtr345_t_A_tulo_1_5d058c040c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RED>>(v1);
    }

    // decompiled from Move bytecode v6
}

