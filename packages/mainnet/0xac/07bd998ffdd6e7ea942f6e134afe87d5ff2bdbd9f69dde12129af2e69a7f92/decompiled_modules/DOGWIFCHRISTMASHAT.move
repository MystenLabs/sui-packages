module 0xac07bd998ffdd6e7ea942f6e134afe87d5ff2bdbd9f69dde12129af2e69a7f92::DOGWIFCHRISTMASHAT {
    struct DOGWIFCHRISTMASHAT has drop {
        dummy_field: bool,
    }

    fun init_internal(arg0: DOGWIFCHRISTMASHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGWIFCHRISTMASHAT>(arg0, 6, b"DOGWIFCHRISTMASHAT", b"Dog wif iconic but new christmas hat", b"Christmas is comming. This cute dog wif christmas hat is the mascot for this BULLRUN crypto christmas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/yYGxV4X/Dog-with-Christmas.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGWIFCHRISTMASHAT>>(v1);
        0x2::coin::mint_and_transfer<DOGWIFCHRISTMASHAT>(&mut v2, 4200000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWIFCHRISTMASHAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

