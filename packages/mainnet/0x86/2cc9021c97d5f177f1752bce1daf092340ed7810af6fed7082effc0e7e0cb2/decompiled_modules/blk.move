module 0x862cc9021c97d5f177f1752bce1daf092340ed7810af6fed7082effc0e7e0cb2::blk {
    struct BLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLK>(arg0, 6, b"BLK", b"The Block", b"The building block of all chains. Make a house? Make a basement? Make a blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/block_9e7d4c5181.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLK>>(v1);
    }

    // decompiled from Move bytecode v6
}

