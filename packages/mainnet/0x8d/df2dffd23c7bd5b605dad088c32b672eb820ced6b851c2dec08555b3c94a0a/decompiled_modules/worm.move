module 0x8ddf2dffd23c7bd5b605dad088c32b672eb820ced6b851c2dec08555b3c94a0a::worm {
    struct WORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORM>(arg0, 6, b"WORM", b"Wormlag Sui", b"Worm is just a worm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wormlag_c4fab2e6ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORM>>(v1);
    }

    // decompiled from Move bytecode v6
}

