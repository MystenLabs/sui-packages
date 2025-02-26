module 0x3b9008d5aa78032a831b00d08dcfca042a0190f6fac9426e88fe7393bd98c4bc::eggdoge {
    struct EGGDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGDOGE>(arg0, 9, b"EggDoge", b"EggDoge Sui", x"576861742077617320626f726e2066697273742c2074686520656767206f722074686520446f67653f0d0a54484520454747444f47452021213f213f213f213f213f213f213f3f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfFHbWLg1zEwNdsBnX81pKsS2ucAfgLvqMBMbb7vkP3tB")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EGGDOGE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGGDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGDOGE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

