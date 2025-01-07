module 0x721ccbb8a5a37324d78a665f5f000d83feca809080ca5059621d07313250cfee::ftr {
    struct FTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTR>(arg0, 9, b"FTR", b"Future", b"Future Coin is a digital currency aimed at empowering innovative technology startups. By investing in projects that drive progress in AI, blockchain, and renewable energy, holders contribute to a smarter.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2fc9f531-3ce6-40e6-aa4c-68e820eb4876.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

