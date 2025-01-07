module 0xeddabd76341812fdc89bfce47507d417f9593e75ab48d99892651809fa4fe40b::blk {
    struct BLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLK>(arg0, 6, b"BLK", b"DeBlok", b"Wtf else do you need? One block, two block, three block now you've got a whole chain of them. Think bigger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/block_8d92154f17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLK>>(v1);
    }

    // decompiled from Move bytecode v6
}

