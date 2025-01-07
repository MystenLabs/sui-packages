module 0x51abfced42baa7c27b9311118942bc12c8f43417ee5f5b438aa5fcb0ceadb2f7::see {
    struct SEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEE>(arg0, 6, b"SEE", b"LOOK", b"4", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/na_tra4_2044_1564382699_9e08cb790c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

