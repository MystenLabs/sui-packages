module 0xbc4d2ce868c8003d3d5585ea3291ff9988c2fa7118b2a279e5dbe65052149bbf::chilldeng {
    struct CHILLDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLDENG>(arg0, 9, b"CHILLDENG", b"Chill Deng", b"Chill Deng on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/bafkreig7gzfd5u5dvmmwu3yeexxamle645osbt4kqfjxtf67mbes7cnlsm"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLDENG>>(v1);
        0x2::coin::mint_and_transfer<CHILLDENG>(&mut v2, 1000000000000000000, @0x768299d1d353661ff0b705870ab069cb29945f2fd00ac410dbb19ebf0e77af00, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHILLDENG>>(v2);
    }

    // decompiled from Move bytecode v6
}

