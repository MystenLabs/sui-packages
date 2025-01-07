module 0xee6e3dc0940a2fceb26cc2c711b182191ac58fa2c8195e3a4a902b654c1c0f4e::foryou {
    struct FORYOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORYOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORYOU>(arg0, 9, b"FORYOU", b"Apocalypse", b"Safe the World ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d25e6f2c-b399-4aff-86a1-6d5073ba0318.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORYOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FORYOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

