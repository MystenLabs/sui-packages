module 0xa3a592614ff66655262f50dad6281a9249c3043d2f62e71f670510db2ff8c4dc::babycat {
    struct BABYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYCAT>(arg0, 6, b"BABYCAT", b"Baby Cat", b"babycat is a cute adorable cat that will be an iconic coin in the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000059594_1103cd8e3d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

