module 0x677d2d38d5d39978b3939f587864d7f822e061b8e4081310de82de635d2678b3::Punk {
    struct PUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUNK>(arg0, 9, b"PUNK", b"Punk", b"hello punk this is a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G5NLwsnWkAAFund?format=jpg&name=900x900")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUNK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

