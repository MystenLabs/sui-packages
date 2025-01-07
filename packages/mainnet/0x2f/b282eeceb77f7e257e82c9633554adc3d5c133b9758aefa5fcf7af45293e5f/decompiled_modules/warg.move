module 0x2fb282eeceb77f7e257e82c9633554adc3d5c133b9758aefa5fcf7af45293e5f::warg {
    struct WARG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARG>(arg0, 9, b"WARG", b"Wareg", b"Werase", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4c887236-0942-4d27-a484-66839a078769.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARG>>(v1);
    }

    // decompiled from Move bytecode v6
}

