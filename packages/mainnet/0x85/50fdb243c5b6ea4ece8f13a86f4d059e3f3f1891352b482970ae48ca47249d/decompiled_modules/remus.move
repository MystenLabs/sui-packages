module 0x8550fdb243c5b6ea4ece8f13a86f4d059e3f3f1891352b482970ae48ca47249d::remus {
    struct REMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REMUS>(arg0, 6, b"REMUS", b"Remus Gargoyle - Len Sassaman's dog", b"Remus Gargoyle - Len Sassaman's dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Leonardo_Phoenix_A_charming_black_French_Bulldog_with_a_shiny_1_deca51affa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

