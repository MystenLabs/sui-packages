module 0x26e656ba2cf48666eae07fbdb3446307900ac4b2023d1033137960f848f18847::solo {
    struct SOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLO>(arg0, 9, b"SOLO", b"solo", b"The world's most potential token, convenient and handsome", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/28cc3bec-868b-496a-b3ef-dd4254aa17cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

