module 0xe1fc2aa0030e380bfd3c6dc01c3800e73eae82d02616afe374dbfe7db42e530b::tui {
    struct TUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUI>(arg0, 9, b"TUI", b"Tui", b"Sui the Tui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TUI>(&mut v2, 222222222000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

