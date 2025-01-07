module 0x7f108d1e42988264bef7b275a5cef193c8f9c46fc47ed2358eaa9a7a4614d49e::sneiro {
    struct SNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEIRO>(arg0, 6, b"SNEIRO", b"Super Neiro", b"It's time to forget that the cute Neiro existed. We need another version with strong and charming - $SNEIRO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9697_b477f41ba9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

