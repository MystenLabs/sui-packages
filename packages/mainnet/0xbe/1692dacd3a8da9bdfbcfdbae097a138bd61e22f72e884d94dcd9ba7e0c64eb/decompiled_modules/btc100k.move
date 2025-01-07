module 0xbe1692dacd3a8da9bdfbcfdbae097a138bd61e22f72e884d94dcd9ba7e0c64eb::btc100k {
    struct BTC100K has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC100K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC100K>(arg0, 6, b"BTC100k", b"BTC 100k SOON", b"BTC 100k soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Avatar2_78b1302186.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC100K>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC100K>>(v1);
    }

    // decompiled from Move bytecode v6
}

