module 0x756e326703ca4ba3e0f316f88d5ae73eb5240cb00c2565838a4669f9ed83c190::lynx {
    struct LYNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LYNX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LYNX>(arg0, 6, b"LYNX", b"SUI LYNX", b"The First LYNX on SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_09_32_56_141c743051.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LYNX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LYNX>>(v1);
    }

    // decompiled from Move bytecode v6
}

