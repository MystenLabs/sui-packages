module 0x121bd43e0d893ffbcd43c1420a1a4f14e347d6f69b77fa5bfca4898ba71df2d5::dsf {
    struct DSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSF>(arg0, 6, b"DSF", b"Dog Search Fridge", b"An original Mem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dogsearch_d9af37dc00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSF>>(v1);
    }

    // decompiled from Move bytecode v6
}

