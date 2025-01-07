module 0x63b8eab6499a92d5d78f3bd7022a0b23336e0237de8c688067aaa8d5a1ddbe84::muudeng {
    struct MUUDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUUDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUUDENG>(arg0, 6, b"MUUDENG", b"MUUDENG ON SUI", x"6a6f6f7374206120766972756c20776974746c20686970706f210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/modeeng_8ee66a791c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUUDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUUDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

