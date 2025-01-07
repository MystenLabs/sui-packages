module 0x1aafc0e17a1d3a49d3a8893245d7bc6fbeec67d53ad90f8d1ab533dc25cae71d::booby {
    struct BOOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBY>(arg0, 6, b"BOOBY", b"SUI-FOOTED BOOBY", b"FOOTED BOOBY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x80b3455e1db60b4cba46aba12e8b1e256dd64979_a4b4d920b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

