module 0x88a4a5822fd29390709eed3ab8b9180055c36c8e4ef30b3e87ac913bd96187e3::kabosu {
    struct KABOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABOSU>(arg0, 6, b"KABOSU", b"Kabosui", x"546865206d656d6520717565656e2c20746865206f672c20746865206661636520626568696e6420646f67652e200a0a446f676520616e64204e6569726f20776572652066697273742c20627574206b61626f7375206c6976657320696e206f75722068656172747320666f7265766572210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_03_13_08vdhgh_9b21c8d7c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KABOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

