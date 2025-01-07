module 0xb01f721076188c9b432ebc1a404f039b4b533e18970e64cf0f03bdfb93418977::coronas {
    struct CORONAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORONAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORONAS>(arg0, 9, b"CORONAS", b"WAWE", b"Sui inspires to go further, develop, catch the waves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf4a53a1-ab41-49ac-a4d8-2aab837bf673.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORONAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORONAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

