module 0xce6d07f83d58e85926beb1816ce328cdb01a2eada9e0f5bd1582146d6bfb3941::suiru {
    struct SUIRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRU>(arg0, 6, b"SUIRU", b"Suiruto", b"Suiruto is stealthy, unstoppable, and taking over the Sui Network. Driven by community power, $SUIRU isnt just a token, its a movement. Dont get left behind. Join the ultimate ninja force and rise with the clan!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_b79b22c468.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRU>>(v1);
    }

    // decompiled from Move bytecode v6
}

