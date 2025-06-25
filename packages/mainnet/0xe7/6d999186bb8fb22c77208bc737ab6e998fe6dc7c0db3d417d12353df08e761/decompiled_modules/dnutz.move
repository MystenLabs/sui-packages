module 0xe76d999186bb8fb22c77208bc737ab6e998fe6dc7c0db3d417d12353df08e761::dnutz {
    struct DNUTZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNUTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNUTZ>(arg0, 6, b"DNUTZ", b"Diamond Nuttz", x"4469616d6f6e642068616e642067657420627567206761696e2062757420686176696e67206469616d6f6e64206e7574747a206765747320796f75207269636820626974636821212057656273697465206973206d792078206163636f756e7420676574206174206d652049206e6565642070656f706c6520746f206d616b652061207061676520616e64207368697420636175736520666f6f6c2049e280996d20686f6c64696e67207468657365206e7974747a2074696c2074686520656e64207768656e207765e28099726520726963682e20536f2068656c7020697420676f2121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750854825381.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNUTZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNUTZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

