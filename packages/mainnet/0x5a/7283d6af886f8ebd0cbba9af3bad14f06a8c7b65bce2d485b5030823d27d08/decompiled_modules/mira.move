module 0x5a7283d6af886f8ebd0cbba9af3bad14f06a8c7b65bce2d485b5030823d27d08::mira {
    struct MIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIRA>(arg0, 6, b"MIRA", b"Bitcoin miner", b"Bitcoin miner $MARA honors President-elect Trump's inauguration by mining his portrait into a $BTC block.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000060819_5ae26ea3e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

