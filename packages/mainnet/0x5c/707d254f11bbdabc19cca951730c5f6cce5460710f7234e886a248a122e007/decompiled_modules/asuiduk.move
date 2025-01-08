module 0x5c707d254f11bbdabc19cca951730c5f6cce5460710f7234e886a248a122e007::asuiduk {
    struct ASUIDUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUIDUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUIDUK>(arg0, 6, b"ASUIDUK", b"ASUIDUK!", x"4a757374206c696b65205073796475636b2c207765e28099726520736f6d6574696d6573206f7665727768656c6d6564206279207468652063727970746f20776f726c642e20427574206865792c2077652062656c6965766520696e2074686520706f776572206f6620636f6d6d756e69747920616e6420686176696e672066756e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736336371968.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASUIDUK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUIDUK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

