module 0x23c13cee7e335c76dedbd6285b228b79ebd460ad7a39bf5bed26b32f92f065b0::ott {
    struct OTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTT>(arg0, 9, b"OTT", b"Otter", b"Happy Otter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8573096-737d-45c3-8202-4c0edce08969.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

