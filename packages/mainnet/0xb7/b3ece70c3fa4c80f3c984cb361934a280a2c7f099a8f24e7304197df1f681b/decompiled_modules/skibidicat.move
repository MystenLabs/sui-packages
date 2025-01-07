module 0xb7b3ece70c3fa4c80f3c984cb361934a280a2c7f099a8f24e7304197df1f681b::skibidicat {
    struct SKIBIDICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIBIDICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIBIDICAT>(arg0, 6, b"SKIBIDICAT", b"SKIBIDI CAT", b"First skibidi cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_EA_4_E201_04_DA_4_B0_B_AD_75_0603_A6_EFB_370_6825ad6dba.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIBIDICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKIBIDICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

