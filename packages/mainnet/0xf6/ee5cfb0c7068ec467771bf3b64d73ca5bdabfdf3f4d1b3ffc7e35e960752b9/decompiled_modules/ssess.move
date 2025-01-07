module 0xf6ee5cfb0c7068ec467771bf3b64d73ca5bdabfdf3f4d1b3ffc7e35e960752b9::ssess {
    struct SSESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSESS>(arg0, 6, b"SSESS", b"Sui Seahorses", b"Seahorses on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_15_07_52_34f1ceee6b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

