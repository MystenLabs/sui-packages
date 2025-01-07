module 0x966307685921336c8d095f8fac9d795d5b03f3c80b9e2abaf07763f93fe02037::hug_life {
    struct HUG_LIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUG_LIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUG_LIFE>(arg0, 9, b"HUG_LIFE", b"HugginsRen", b"Hug Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/995bc725-f062-4639-8da6-f27c74390585.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUG_LIFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUG_LIFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

