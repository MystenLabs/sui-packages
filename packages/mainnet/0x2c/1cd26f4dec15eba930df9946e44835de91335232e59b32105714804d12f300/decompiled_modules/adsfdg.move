module 0x2c1cd26f4dec15eba930df9946e44835de91335232e59b32105714804d12f300::adsfdg {
    struct ADSFDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADSFDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADSFDG>(arg0, 9, b"ADSFDG", b"fsfsd", b"dfgfdg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9559a4f1-2094-4ff4-ad1e-8dac534aa563.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADSFDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADSFDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

