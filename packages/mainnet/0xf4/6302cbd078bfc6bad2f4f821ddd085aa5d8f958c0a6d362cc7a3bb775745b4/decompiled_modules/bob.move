module 0xf46302cbd078bfc6bad2f4f821ddd085aa5d8f958c0a6d362cc7a3bb775745b4::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 9, b"BOB", b"Bob the bear", b"I m bob", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPe3b08Bu5qcv_qzsiYPQA05-Pauc1HOVLiw&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOB>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

