module 0x5aead8f46c3890920762e85aa869deee5f697eabf9fcc4237bf2481bfa940cee::popcornman {
    struct POPCORNMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPCORNMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPCORNMAN>(arg0, 6, b"PopcornMan", b"POPCORN", b"I am Popcorn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vt_Jibmk_F_400x400_188686101b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPCORNMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPCORNMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

