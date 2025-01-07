module 0x76c217f023a4d3d725f24909aad80834f8425aecc335c0e06a965df5ac6fd30d::blb {
    struct BLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLB>(arg0, 6, b"BLB", b"BLUB.oO", b"BLUB .oO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5493_40fe75b315.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

