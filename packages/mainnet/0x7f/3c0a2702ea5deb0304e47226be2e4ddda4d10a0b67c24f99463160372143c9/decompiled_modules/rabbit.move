module 0x7f3c0a2702ea5deb0304e47226be2e4ddda4d10a0b67c24f99463160372143c9::rabbit {
    struct RABBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABBIT>(arg0, 6, b"RABBIT", b"Rabbit on Sui", b"The first mini-game app on SUI | https://www.rabbitonsui.pro/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_e5cbc4c418.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RABBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

