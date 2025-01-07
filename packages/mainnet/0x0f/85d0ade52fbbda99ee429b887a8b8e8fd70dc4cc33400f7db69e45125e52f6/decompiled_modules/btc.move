module 0xf85d0ade52fbbda99ee429b887a8b8e8fd70dc4cc33400f7db69e45125e52f6::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 9, b"BTC", b"See", b"It's like ocean token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98ed26ff-058f-4b99-92df-7e444c2f849b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

