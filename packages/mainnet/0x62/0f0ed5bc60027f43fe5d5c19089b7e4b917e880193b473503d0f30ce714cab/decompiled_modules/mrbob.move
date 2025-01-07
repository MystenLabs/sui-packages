module 0x620f0ed5bc60027f43fe5d5c19089b7e4b917e880193b473503d0f30ce714cab::mrbob {
    struct MRBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRBOB>(arg0, 6, b"MRBOB", b"MR BOB", x"4120444543454e5452414c49534544204d4554415645525345205652204e6574776f726b204279207573696e672074686520776f726c642773206d6f737420616476616e636564207265616c2074696d652033440a4372656174696f6e20456e67696e652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736035336886.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRBOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRBOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

