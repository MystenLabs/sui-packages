module 0x1a605a215ddde904e42eae6f42ee1e0ac85bf3415a7ad9dc7b5ccca14b8b79d2::root {
    struct ROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOT>(arg0, 6, b"ROOT", b"ROOTLETS", b"We are Rootards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_07_17_23_56_44_2_8f0cd20c25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

