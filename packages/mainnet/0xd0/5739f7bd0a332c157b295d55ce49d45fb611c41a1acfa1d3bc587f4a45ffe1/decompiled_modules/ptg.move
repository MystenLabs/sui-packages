module 0xd05739f7bd0a332c157b295d55ce49d45fb611c41a1acfa1d3bc587f4a45ffe1::ptg {
    struct PTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTG>(arg0, 9, b"PTG", b"pertameme", b"The first is a meme about one of the institutions in Indonesia, which is one of the largest oil and gas companies in Indonesia. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94c3e190-7fe3-4ff5-adc3-60ae4f79e1fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTG>>(v1);
    }

    // decompiled from Move bytecode v6
}

