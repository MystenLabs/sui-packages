module 0xa47a4560f179731c427946fbd4d6d990a2f4baba142bad5748e65b50f6143326::bod {
    struct BOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOD>(arg0, 6, b"BOD", b"Bates On Dog", b"Trade in your jets and beavers for a dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014015_c5bfab52b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

