module 0x781e2338cb323262d033dfa0bb561f2b2d5e37b45d7f7c8f7c829a14538474bc::maru {
    struct MARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARU>(arg0, 6, b"MARU", b"Maru Taro", x"4d6172757461726f206f6e205375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_f7ea3c2c46.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

