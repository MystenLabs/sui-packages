module 0xe7cb65136ea3ce9735fe8c424c30fd1342ade83a2f0f3b8069cca8eba5e6d9a1::graced {
    struct GRACED has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACED>(arg0, 9, b"GRACED", b"Gospel sav", b"CHRIST DIED FOR SINNERS, WE ARE FORGIVEN IN HIM.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ead682ca-7a8f-4f93-906d-bb99b295cf77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRACED>>(v1);
    }

    // decompiled from Move bytecode v6
}

