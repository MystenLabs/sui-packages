module 0xd1ca1befc176daf1778e11fa5fcfbffd605ef052bf9aff878c8cb50495849a7f::wfa {
    struct WFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WFA>(arg0, 9, b"WFA", b"WaveForAll", b"Dedicated for Wave Team", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/835547ac-adc0-441e-bed1-d945c1c14b13.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

