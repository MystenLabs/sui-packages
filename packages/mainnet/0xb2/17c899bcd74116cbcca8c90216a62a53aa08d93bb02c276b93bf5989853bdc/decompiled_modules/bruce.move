module 0xb217c899bcd74116cbcca8c90216a62a53aa08d93bb02c276b93bf5989853bdc::bruce {
    struct BRUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUCE>(arg0, 6, b"BRUCE", b"brucethecow sui", b"Herrera and his cow Bruce have become TikTok sensations after videos of them attempting to make pancakes, sandwiches and desserts (at @elias_filmz) have scored more than 100 million views and counting. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241229_011925_123_f24d87a5f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

