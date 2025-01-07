module 0x4db880747b9a37488172c12470c9da9bccd9316629f3bd1ae4d1e7cce19af3f1::arowana {
    struct AROWANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AROWANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AROWANA>(arg0, 6, b"Arowana", b"Platinum Arowana", b"If wishes were fishes wed all swim in riches", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Top_10_Most_Expensive_Fish_In_The_World_470027c7ee.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AROWANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AROWANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

