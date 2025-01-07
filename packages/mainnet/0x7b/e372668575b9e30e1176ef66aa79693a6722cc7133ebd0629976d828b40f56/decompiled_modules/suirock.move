module 0x7be372668575b9e30e1176ef66aa79693a6722cc7133ebd0629976d828b40f56::suirock {
    struct SUIROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIROCK>(arg0, 6, b"SUIROCK", b"Sui Rock", x"24535549524f434b20697320746865206d6f7374207573656c657373206d656d6520636f696e20746f2065766572206578697374206f6e204d6f766570756d702e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_5241cd69d2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

