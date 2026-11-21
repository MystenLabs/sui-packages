module 0x6d83bf15feadcf969af885e150111871a6f35f80c263bc07b644a34336231566::bcat {
    struct BCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCAT>(arg0, 9, b"BCAT", b"BLAST CAT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"0x2d540c00977909b5481b33d014cd6c5b683015cdfa0b2ed19efe20f8b803b46c::bcat::BCAT")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BCAT>>(0x2::coin::mint<BCAT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCAT>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

