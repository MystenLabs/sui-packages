module 0x5f091fa588112c116be45cd9b47f9addd53beb87fc9b1ffc2568428004f5bb59::chung {
    struct CHUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUNG>(arg0, 6, b"CHUNG", b"EVUN CHUNG", b"Teh owner of SUI blokchein", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_07_15_32_39_0e5081d010.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

