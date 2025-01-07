module 0xc07f6cc6d031080cb0543c17ed8bf20160f0150c8b29e71563a9c005bcaabf0a::tui {
    struct TUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUI>(arg0, 9, b"TUI", b"Suiramp", b"Suiramp - Make Great Sui Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ph-test-11.slatic.net/p/60a644693a2caac0c4524d585ecf4e74.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

