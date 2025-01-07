module 0xb343ca16a76f4eda4fa25a658d85f39cb773c82b0a04082c9e1aba1d7fc81b68::elontrump {
    struct ELONTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONTRUMP>(arg0, 6, b"ElonTrump", b"ElonAndTrump", x"f09f91be2057656c636f6d6520746f20456c6f6e416e645472756d702120f09f91be0a0a57652061726520746865204d4154524958206f66207468652063727970746f20756e6976657273652c206865726520746f207265766f6c7574696f6e697a6520746865206d61726b65742120f09f92a5f09f9a800a436f6d6520616e642062652070617274206f66206f7572206d6567612070726f6a6563742120f09f8c90f09f94a5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731044058086.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONTRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONTRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

