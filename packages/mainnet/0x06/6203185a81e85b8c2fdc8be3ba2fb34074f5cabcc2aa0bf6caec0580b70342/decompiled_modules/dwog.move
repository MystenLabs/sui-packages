module 0x66203185a81e85b8c2fdc8be3ba2fb34074f5cabcc2aa0bf6caec0580b70342::dwog {
    struct DWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWOG>(arg0, 6, b"DWOG", b"Dwog on Sui", b"wwooooooorrff awwrff awrrrf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_c7ba76c203.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

