module 0x51841b51e0f9393b245041087cce78efcb251ed27f73e0b32305c8ab4fc1eb16::zbrb {
    struct ZBRB has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZBRB>, arg1: 0x2::coin::Coin<ZBRB>) {
        assert!(false == false, 100);
        0x2::coin::burn<ZBRB>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZBRB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<ZBRB>(0x2::coin::supply<ZBRB>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<ZBRB>>(0x2::coin::mint<ZBRB>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ZBRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZBRB>(arg0, 6, b"ZBRB", b"Zebra bro", b"I'm zebra bro and you're not.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/0ofU6-KOBSD_CxwHvt8hMfcOF2PskwM-qahDPUh17Tk?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZBRB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZBRB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

