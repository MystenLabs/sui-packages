module 0x950a5ab4256612eefc7a8399a73a63c361d98c3b9f011bec4f54ffbd273830de::manus {
    struct MANUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANUS>(arg0, 6, b"Manus", b"ManusAI", b"Manus is a general AI agent that bridges minds and actions: it doesn't just think, it delivers results.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_QHSXMJ_0_400x400_3a737430f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

