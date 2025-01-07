module 0xf50581f7a4e6011e847ecc144e6ec55cb634e56ef492fd609853ba096aa1fc0e::ptc {
    struct PTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTC>(arg0, 9, b"PTC", b"Peter Coin", b"Nikola Peter Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf79b3a7-5705-49f9-9f30-142427633e7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

