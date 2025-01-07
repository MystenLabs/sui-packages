module 0x273d61e326abdfd449e3407939b7aa28fa8e89e104526e0cd150ebb6cbcfe237::suin {
    struct SUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIN>(arg0, 6, b"Suin", b"Suinuki", b"Suinuki is a mystical blue tanuki on the Sui blockchain, known for bringing luck, guidance, and playful energy to its digital community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_e426df76bc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

