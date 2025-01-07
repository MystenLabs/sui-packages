module 0xe6a2ae7db84321ec087dec792e6ce8f524764c9b91a8dec8997172596a4f8b7d::tlc {
    struct TLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TLC>(arg0, 9, b"TLC", b"TrumpLCoin", b"Trump Lin Coin is our the Future! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d5b3fc0-37bb-4e41-8fc8-cb66974d8b7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TLC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

