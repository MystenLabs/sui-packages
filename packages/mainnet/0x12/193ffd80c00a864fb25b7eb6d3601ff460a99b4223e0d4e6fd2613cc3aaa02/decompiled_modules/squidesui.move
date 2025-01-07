module 0x12193ffd80c00a864fb25b7eb6d3601ff460a99b4223e0d4e6fd2613cc3aaa02::squidesui {
    struct SQUIDESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDESUI>(arg0, 6, b"SQUIDESUI", b"SQUID SUI", b"Squid Sui is a new meme coin built on the Sui blockchain. Designed with a strong community focus, Squid Sui aims to be a leading cryptocurrency within the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/movepump_logo_2_d54ef58091.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

