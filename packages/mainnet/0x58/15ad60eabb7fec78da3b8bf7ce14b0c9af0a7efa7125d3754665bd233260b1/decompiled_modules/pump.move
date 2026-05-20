module 0x5815ad60eabb7fec78da3b8bf7ce14b0c9af0a7efa7125d3754665bd233260b1::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 9, b"MAZU", x"e5a688e7a596", x"e684bfe5a688e7a596e7bb99e682a8e5b8a6e69da5e5a5bde8bf90efbc8ce5b9b3e5ae89efbc81", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://zh.wikipedia.org/wiki/File:Wood_Statue_of_Mazu_Late_19th_century_CE_Qing_Dynasty_(1644-1911_CE)_China.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PUMP>>(0x2::coin::mint<PUMP>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

