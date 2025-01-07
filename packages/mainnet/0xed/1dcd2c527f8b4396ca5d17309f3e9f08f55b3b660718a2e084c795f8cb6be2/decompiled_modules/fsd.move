module 0xed1dcd2c527f8b4396ca5d17309f3e9f08f55b3b660718a2e084c795f8cb6be2::fsd {
    struct FSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSD>(arg0, 9, b"FSD", b"FGWE", b"VCS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79bb0153-9ad9-4976-8acb-2af90519b4ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

