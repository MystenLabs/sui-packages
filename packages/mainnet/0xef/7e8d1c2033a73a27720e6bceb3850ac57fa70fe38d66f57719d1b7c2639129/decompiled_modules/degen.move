module 0xef7e8d1c2033a73a27720e6bceb3850ac57fa70fe38d66f57719d1b7c2639129::degen {
    struct DEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGEN>(arg0, 6, b"DEGEN", b"degen sui", b"Hai! My name is Degen, I'm an Otter! I live in Indonesia, and I have more than a billion views across all platforms. Come swim with me :)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Y_Anl_Hyj_Y_400x400_10b43241c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

