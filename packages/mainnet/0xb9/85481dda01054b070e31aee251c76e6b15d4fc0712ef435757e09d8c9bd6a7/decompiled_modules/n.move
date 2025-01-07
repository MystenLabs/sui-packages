module 0xb985481dda01054b070e31aee251c76e6b15d4fc0712ef435757e09d8c9bd6a7::n {
    struct N has drop {
        dummy_field: bool,
    }

    fun init(arg0: N, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<N>(arg0, 9, b"N", b"NAME", b"Name N", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0b5e775-d7d3-4857-bb88-4b344b1636e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<N>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<N>>(v1);
    }

    // decompiled from Move bytecode v6
}

