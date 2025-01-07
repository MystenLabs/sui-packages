module 0xe2ce3da8aacc3c37ba98ae23fec7536a9faf7fff291eea9339de36ea9eb1de47::graced {
    struct GRACED has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACED>(arg0, 9, b"GRACED", b"Gospel sav", b"CHRIST DIED FOR SINNERS, WE ARE FORGIVEN IN HIM.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c252b39-cf4a-4df7-8213-00744119dddc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACED>>(v1);
    }

    // decompiled from Move bytecode v6
}

