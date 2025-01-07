module 0xefe555c1bef7c58b58f7e4c2a7d529d296ba5fc3a7a8eb3759d0499d25299ca2::mola {
    struct MOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLA>(arg0, 6, b"MOLA", b"MOLA SUI", x"4b6f6f6b6965737420476f6f6662616c6c73206f6620746865205365612e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/63_E0_Kl_M_400x400_7dddacd924.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

