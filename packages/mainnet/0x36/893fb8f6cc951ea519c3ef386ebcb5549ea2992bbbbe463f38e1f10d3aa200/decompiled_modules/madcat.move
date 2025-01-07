module 0x36893fb8f6cc951ea519c3ef386ebcb5549ea2992bbbbe463f38e1f10d3aa200::madcat {
    struct MADCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MADCAT>(arg0, 6, b"MADCAT", b"MAD CAT", b"Have you ever seen a more stylish cat than this mad kitty ?! Not so \"Kitty\" by the way... buy into the madness of meme coins... SUUUUUUUUIIIIIIIIII !!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MAD_CAT_6db2d92714.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MADCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MADCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

