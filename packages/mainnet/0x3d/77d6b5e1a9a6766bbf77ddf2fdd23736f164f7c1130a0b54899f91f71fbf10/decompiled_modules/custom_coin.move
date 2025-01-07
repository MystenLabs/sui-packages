module 0x3d77d6b5e1a9a6766bbf77ddf2fdd23736f164f7c1130a0b54899f91f71fbf10::custom_coin {
    struct CUSTOM_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUSTOM_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let (v1, v2) = 0x2::coin::create_currency<CUSTOM_COIN>(arg0, v0, b"SHIB", b"Shiba Inu", b"Shiba Inu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1683677433369-de2fdd8e3afd415f264507055d924446.gif")), arg1);
        let v3 = v1;
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<CUSTOM_COIN>(&mut v3, 1000000000 * 0x2::math::pow(10, v0), v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUSTOM_COIN>>(v3, v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUSTOM_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

