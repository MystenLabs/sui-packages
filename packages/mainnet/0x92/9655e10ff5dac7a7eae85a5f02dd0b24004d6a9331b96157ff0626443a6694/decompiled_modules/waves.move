module 0x929655e10ff5dac7a7eae85a5f02dd0b24004d6a9331b96157ff0626443a6694::waves {
    struct WAVES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVES>(arg0, 9, b"WAVES", b"Ocean", b"Waves crypto currency token logo on gold coin black themed design. vector illustration for cryptocurrency symbols or icons. can used for banner, ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82eea31f-0e1c-4bf4-aaa3-ddeb0e9e3ba0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVES>>(v1);
    }

    // decompiled from Move bytecode v6
}

