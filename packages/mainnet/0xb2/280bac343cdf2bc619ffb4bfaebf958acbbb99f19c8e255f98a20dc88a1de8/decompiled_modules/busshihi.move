module 0xb2280bac343cdf2bc619ffb4bfaebf958acbbb99f19c8e255f98a20dc88a1de8::busshihi {
    struct BUSSHIHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUSSHIHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUSSHIHI>(arg0, 9, b"BUSSHIHI", b"BusBus", b"Buss nhes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5f10802-bbc1-45ab-a48a-4e4119f2fcc7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUSSHIHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUSSHIHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

