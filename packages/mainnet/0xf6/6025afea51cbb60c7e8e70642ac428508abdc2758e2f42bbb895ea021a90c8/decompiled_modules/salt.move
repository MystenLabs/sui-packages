module 0xf66025afea51cbb60c7e8e70642ac428508abdc2758e2f42bbb895ea021a90c8::salt {
    struct SALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALT>(arg0, 9, b"SALT", b"SEASALT", x"5345412053414c5420282453414c5429200a4a757374206c696b652073616c7420697320657373656e7469616c20666f7220666c61766f722c202453414c54206164647320737069636520746f207468652063727970746f20776f726c6420627920656d626f6479696e672074686520737069726974206f66206c69676874686561727465646e65737320616e6420637265617469766974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/99c4a50f-6ade-4922-b009-a88175454cbd-SEA SALT.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SALT>>(v1);
    }

    // decompiled from Move bytecode v6
}

