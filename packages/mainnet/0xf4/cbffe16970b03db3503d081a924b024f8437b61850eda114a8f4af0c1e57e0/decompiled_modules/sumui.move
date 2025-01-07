module 0xf4cbffe16970b03db3503d081a924b024f8437b61850eda114a8f4af0c1e57e0::sumui {
    struct SUMUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMUI>(arg0, 6, b"SUMUI", b"SUMMU", b"Meet $SUMUI, the meme bull on the Sui chain! Hes here to bring the bullish energy and good vibes to the blockchain world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x6db939d4b30efddf6824d43fa7777f6e430865c9cdfa495f18049b0c4c71177b_sumu_sumu_2a44d32ecf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

