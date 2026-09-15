module 0xa1fd1c75cd3b541db7b4254fbae26dae17ce691f46e61e46068a8a61848be340::otter {
    struct OTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTER>(arg0, 6, b"OTTER", b"OTTER", x"4d65657420244f545445522c2074686520637574657374206d6173636f742073757266696e67207468652053756920626c6f636b636861696e2120506f7765726564206279206c696768742d7370656564207472616e73616374696f6e7320616e6420756e73746f707061626c6520636f6d6d756e6974792076696265732c20746869732077617465722d6c6f76696e67206275646479206973206865726520746f2068656c7020796f75206e61766967617465207468652057656233206f6365616e206566666f72746c6573736c792e2043617463682074686520776176652c206a6f696e20746865206f74746572207061636b2c20616e64206c6574e2809973206d616b6520776176657320746f6765746865722120f09f8c8ae29ca80a0a2353756920234f54544552202357656233", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/S5u29xlymtKpeSHkOsXo8eO8iR7s2J7AZhtVGqztsGs")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<OTTER>>(0x2::coin::mint<OTTER>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTER>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTTER>>(v1);
    }

    // decompiled from Move bytecode v7
}

