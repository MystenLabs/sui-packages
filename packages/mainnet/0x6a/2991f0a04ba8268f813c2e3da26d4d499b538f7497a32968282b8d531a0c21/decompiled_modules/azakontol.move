module 0x6a2991f0a04ba8268f813c2e3da26d4d499b538f7497a32968282b8d531a0c21::azakontol {
    struct AZAKONTOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZAKONTOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZAKONTOL>(arg0, 9, b"AZAKONTOL", b"Aza kontol", b"Aza itu lo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/28b42845-2c1c-45eb-ae71-62d43f6844ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZAKONTOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AZAKONTOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

