module 0xe600edee41f1156b8c506873909b5ff38735a98f5a51ed6645df683b4d7db7fb::shycat {
    struct SHYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHYCAT>(arg0, 6, b"ShyCAT", b"shycat", b"Celebrating the adorable world of shy cats!  No project managers, just pure feline fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B_Xy_3pd7_400x400_575552fbd2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

