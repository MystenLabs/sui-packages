module 0xd4fdd7ead84afb35ea1e45639c918cf2a3442ab8aa33ce72b2dee763000124ed::xiaojiujiu {
    struct XIAOJIUJIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIAOJIUJIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIAOJIUJIU>(arg0, 6, b"XIAOJIUJIU", b"$XIAOJIUJIU", b"$XIAOJIUJIU ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ntsb_U9_OL_400x400_58c5478571.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIAOJIUJIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XIAOJIUJIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

