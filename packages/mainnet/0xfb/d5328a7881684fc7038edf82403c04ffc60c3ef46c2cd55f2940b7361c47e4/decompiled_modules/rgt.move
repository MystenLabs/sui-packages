module 0xfbd5328a7881684fc7038edf82403c04ffc60c3ef46c2cd55f2940b7361c47e4::rgt {
    struct RGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RGT>(arg0, 9, b"RGT", b"Regent", b"Be Brave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0910b7b-83a0-4523-9974-ba54af374306.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

