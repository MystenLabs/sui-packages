module 0x1dae2cf1b631cb584d867fe487e0c9f5d0c2289abb52a53dba90b0d489e3388b::heysiri {
    struct HEYSIRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEYSIRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEYSIRI>(arg0, 6, b"HEYSIRI", b"#1 most famous AI", b"THE FIRST SUI MEMECOIN BASED ON AI META", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_13_21_11_bd78081560.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEYSIRI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEYSIRI>>(v1);
    }

    // decompiled from Move bytecode v6
}

