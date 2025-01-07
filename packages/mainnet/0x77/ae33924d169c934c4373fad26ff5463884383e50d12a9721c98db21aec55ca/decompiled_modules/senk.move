module 0x77ae33924d169c934c4373fad26ff5463884383e50d12a9721c98db21aec55ca::senk {
    struct SENK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENK>(arg0, 6, b"SENK", b"BLUE SENK", b"Meet Senk, once celebrated as the internet's coolest seal. After facing significant setbacks, Senk found himself back at square one, destitute after losing everything in tradinghis money, his wife, and even his igloo. But Senk is no quitter. Fueled by a relentless vision, he is determined to rebuild and succeed. Will you join him on his remarkable journey to redemption?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3827_28d8b61838.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENK>>(v1);
    }

    // decompiled from Move bytecode v6
}

