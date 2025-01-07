module 0x9317bf5f7c4318ac91aaa2c282ece33dd40044da8a967a0c5f91adf8287b120b::gld {
    struct GLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLD>(arg0, 9, b"GLD", b"Gold", b"this tkoen like gold!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/757854a9-7d16-4e4b-ad28-8286da77ef98.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

