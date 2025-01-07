module 0xe53e960a328f43afc7acbfb2544e8b55d757fde036a23d3e2ebad2c73e25126b::peng {
    struct PENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENG>(arg0, 6, b"PENG", b"PolarPenguin", b"PolarPenguin (PENG) is a cryptocurrency with a heart as warm as the Arctic is cold! Inspired by the resilient and adorable penguin, this token aims to support wildlife conservation efforts in polar regions. By holding PENG, you're joining a community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951857229.12")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

