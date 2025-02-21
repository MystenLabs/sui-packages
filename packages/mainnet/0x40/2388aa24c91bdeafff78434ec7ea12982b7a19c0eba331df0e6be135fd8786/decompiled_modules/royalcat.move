module 0x402388aa24c91bdeafff78434ec7ea12982b7a19c0eba331df0e6be135fd8786::royalcat {
    struct ROYALCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROYALCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROYALCAT>(arg0, 6, b"RoyalCat", b"Royal Cat On Sui", b"Share stories, pictures, and videos about your lovely cats.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/60dh2gtgs4a3s86mth8y_1_6845830001.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROYALCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROYALCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

