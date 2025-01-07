module 0x574207d4bf00b72ac5bf39b8530dd716efd5628db868b11295715f8f48c8efe5::hkt {
    struct HKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HKT>(arg0, 9, b"HKT", b"HRE", b"new", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8a0b21b-c98f-4689-ba24-a1b5b7000af3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

