module 0x871090af2166912b644be1ed968910bfcb5cb3f5df1eed264c904bc55f8c889b::suiamee {
    struct SUIAMEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAMEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAMEE>(arg0, 6, b"SUIAMEE", b"SUI AMEE", b"AMEE is singer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Amee_2020_76c8a66378.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAMEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAMEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

