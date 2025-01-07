module 0x83d4aa68d3ba21812d1b9679a71968eaf772d4ddfba3029759df459e95456f95::aaaa {
    struct AAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAA>(arg0, 6, b"aaaA", b"aaaAAA", b"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaa_AAAA_Aaaa_AA_Aaa_AAA_Aaa_A_Aaa_A_6e76cd3497.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

