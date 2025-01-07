module 0x494de27c9e7c9c1a2de43794d318b6deefe30841b84c955726acf123953c1d29::kong {
    struct KONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONG>(arg0, 9, b"KONG", b"Ca kong", b"Meme 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f349dd7-63c6-42d6-ba71-a0635e3cd6d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

