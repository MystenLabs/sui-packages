module 0x46c0e6ffa84a607662bd8162b78f164a055701d45eebf8a6158954bb9037102f::good12 {
    struct GOOD12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOD12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOD12>(arg0, 9, b"GOOD12", b"@meme14", b"Mamaola", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a93cbfae-98a6-4f02-8352-0b114cb3b065.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOD12>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOOD12>>(v1);
    }

    // decompiled from Move bytecode v6
}

