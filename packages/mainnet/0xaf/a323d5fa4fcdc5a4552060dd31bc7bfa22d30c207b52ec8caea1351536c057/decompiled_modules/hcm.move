module 0xafa323d5fa4fcdc5a4552060dd31bc7bfa22d30c207b52ec8caea1351536c057::hcm {
    struct HCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCM>(arg0, 9, b"HCM", b"ITSHOANGCM", b"HoangCM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b3d1445-98a5-45de-863a-c5dae8dc435f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

