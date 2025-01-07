module 0xd06514291d305da2981959bf185635d25de07db5c5e22c368a14fcf57608f080::dgsu {
    struct DGSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGSU>(arg0, 6, b"DGSU", b"DOGE", b"DOGE ON SUI!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3e1526061e50e93ede083b16d017686b_ab9e0b1252.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

