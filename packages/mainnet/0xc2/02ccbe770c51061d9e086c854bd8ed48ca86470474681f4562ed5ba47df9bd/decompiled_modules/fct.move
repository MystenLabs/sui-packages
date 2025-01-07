module 0xc202ccbe770c51061d9e086c854bd8ed48ca86470474681f4562ed5ba47df9bd::fct {
    struct FCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCT>(arg0, 9, b"FCT", b"FunCat", b"FunCat is a unique meme token designed to bring fun and creativity to trading on the Sui blockchain. With FunCat, trading is not just about finance but also about entertainment and community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6da017b3-e0f7-4359-afef-0477dc48188e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

