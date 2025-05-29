module 0x2d83985272971d8e58edd7aca7cee4a233d5d462b5d66b56dae05b8fe3196b5f::hyper {
    struct HYPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPER>(arg0, 6, b"HYPER", b"HYPER on SUI", x"576861747320616c6c2074686520687970653f0a4879706572206f6e207375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7274_059aa7e552.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

