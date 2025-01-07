module 0xa5db1aa90669e9e73c63f703d14f7b865bdef82084011fa21b76704b7a4056c2::blk6900 {
    struct BLK6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLK6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLK6900>(arg0, 6, b"BLK6900", b"BLK", b"Blackrock6900 is here to establish dominance on the blockchain after monopolizing the real world. Join us @ http://t.me/blk6900cto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241013170235_0f11c0e14b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLK6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLK6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

