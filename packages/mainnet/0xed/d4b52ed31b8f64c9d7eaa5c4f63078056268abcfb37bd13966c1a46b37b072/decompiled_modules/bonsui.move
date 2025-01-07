module 0xedd4b52ed31b8f64c9d7eaa5c4f63078056268abcfb37bd13966c1a46b37b072::bonsui {
    struct BONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONSUI>(arg0, 6, b"BONSUI", b"BonSui", b"BONSAI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_203634_8257f2d21a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

