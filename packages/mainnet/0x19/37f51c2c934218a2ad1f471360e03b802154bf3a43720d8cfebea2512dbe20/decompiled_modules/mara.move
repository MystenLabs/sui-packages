module 0x1937f51c2c934218a2ad1f471360e03b802154bf3a43720d8cfebea2512dbe20::mara {
    struct MARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARA>(arg0, 6, b"MARA", b"Bitcoin miner", b"Bitcoin miner $MARA honors President-elect Trump's inauguration by mining his portrait into a $BTC block.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000060819_5ae26ea3e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

