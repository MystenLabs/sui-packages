module 0x1f6ae83872db8b22f96b450e51ae18691d0bb7ca6a7e3d548aabce470ee53986::bok {
    struct BOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOK>(arg0, 6, b"BOK", b"Bok Chick", b"Utility oriented chiken in sui ! Keep Evolving!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000074491_368a7e0a63.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

