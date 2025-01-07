module 0xe3e18469fc5dd7175ea9f748065cfff52c0611884b3f3cd23b68626d8464b969::geco {
    struct GECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GECO>(arg0, 6, b"GECO", b"geco the gecko", x"4d454554204745434f2c2041204c4149442d4241434b2c0a465249454e444c592c204249472d445245414d494e47204745434b4f0a46524f4d20544845204d494e44204f46205045504520544845", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000117281_87cd2c40b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GECO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GECO>>(v1);
    }

    // decompiled from Move bytecode v6
}

