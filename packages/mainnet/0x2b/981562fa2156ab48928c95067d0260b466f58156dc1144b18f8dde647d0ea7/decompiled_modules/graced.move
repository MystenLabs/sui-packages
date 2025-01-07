module 0x2b981562fa2156ab48928c95067d0260b466f58156dc1144b18f8dde647d0ea7::graced {
    struct GRACED has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACED>(arg0, 9, b"GRACED", b"Gospel sav", b"CHRIST DIED FOR SINNERS, WE ARE FORGIVEN IN HIM.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4360adb-4004-4002-a6e7-9c94cff8aa7e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACED>>(v1);
    }

    // decompiled from Move bytecode v6
}

