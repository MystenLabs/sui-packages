module 0xf5ffe57cff7e1648316f2d00eba3a543a572360edf63d7d5583178c9c4df1052::btw {
    struct BTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTW>(arg0, 6, b"BTW", b"Banana Tape Wall", b"It's just a banana taped to a wall.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BTW_LOGO_76d7632eac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTW>>(v1);
    }

    // decompiled from Move bytecode v6
}

