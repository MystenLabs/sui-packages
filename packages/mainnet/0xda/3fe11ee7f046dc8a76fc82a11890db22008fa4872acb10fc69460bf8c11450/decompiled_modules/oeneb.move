module 0xda3fe11ee7f046dc8a76fc82a11890db22008fa4872acb10fc69460bf8c11450::oeneb {
    struct OENEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OENEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OENEB>(arg0, 9, b"OENEB", b"henen", b"ve ev", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce71e44e-fbf1-417a-98f6-6fadc36e5580.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OENEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OENEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

