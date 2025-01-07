module 0x80dee81c3244f8f3dc0eefc793cdf9671032a44e9c86e9de7f28e9310050d399::wct {
    struct WCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCT>(arg0, 9, b"WCT", b"WiCat", b"WiCat is a meme based decentralized token with powerful ecosystem. It is very unique in the crypto world. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d4d5577c-3c65-40f1-9382-ab37988cb5da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

