module 0x13d81fd1a1d9fbef3aeed5b0836507b8c14e8869f36995e8dfb0a3cd3bece0d::sucat {
    struct SUCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCAT>(arg0, 6, b"SUCAT", b"Super Cat", b"SuiSuperCat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kucing_2_d70c95f8a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

