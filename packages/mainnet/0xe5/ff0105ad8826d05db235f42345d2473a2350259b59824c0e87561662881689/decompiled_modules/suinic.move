module 0xe5ff0105ad8826d05db235f42345d2473a2350259b59824c0e87561662881689::suinic {
    struct SUINIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIC>(arg0, 6, b"Suinic", b"SUPER SUINIC", b"Super Suinic is a new, exciting project that's just arrived on the Sui Blockchain. This cute superhero is quickly becoming popular and is expected to grow into a big community. If you're interested in being part of something new and exciting, check out Super Suinic!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_08_08_47_5e1557ba2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

