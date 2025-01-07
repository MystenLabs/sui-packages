module 0x207a75be606c7832574d0006811f232caac0820f5c1c0cf108ca7679396feb94::dolphin {
    struct DOLPHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLPHIN>(arg0, 6, b"Dolphin", b"Dolph", b"launched on 9.12.24 - - world dolphin day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_12_140812_18891386a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLPHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLPHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

