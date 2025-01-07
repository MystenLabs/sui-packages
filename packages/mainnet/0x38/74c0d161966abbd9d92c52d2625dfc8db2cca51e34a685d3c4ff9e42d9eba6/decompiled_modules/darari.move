module 0x3874c0d161966abbd9d92c52d2625dfc8db2cca51e34a685d3c4ff9e42d9eba6::darari {
    struct DARARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARARI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARARI>(arg0, 9, b"DARARI", b"DARK", b"HAHAHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5931c3f-44e4-40eb-8961-d65de50316f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARARI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DARARI>>(v1);
    }

    // decompiled from Move bytecode v6
}

