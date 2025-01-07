module 0x85fb0ec4f0acf05ad0ce6dac76c9803613c352441f501869e18514cc925f9a57::wame {
    struct WAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAME>(arg0, 9, b"WAME", b"WaveMeme", b"WameMemecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5f5758e-33ad-4105-81c0-c8e3b9f34ed9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

