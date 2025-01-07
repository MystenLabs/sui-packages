module 0x757ab0fa595888aa1e77f15d253cf856e9960ca6533775abe4bc72abcd844e5b::copter {
    struct COPTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: COPTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COPTER>(arg0, 6, b"Copter", b"Catcopter", b"No bird is safe from Catcopter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0561_9c60630fc6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COPTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COPTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

