module 0xfa334d06ebdfbb931a94f4ce3b49464563e2112d1f5b2588f1b2c0cf758cfdbf::bft {
    struct BFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFT>(arg0, 9, b"BFT", b"BACKFIGHT", b"backfight meme coin for trading!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1152d87b-65e6-4287-b166-d5d00aed953e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

