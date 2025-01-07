module 0x6533765e7b3b18b355b94f009176d44d577ce07a26801776907ef94b02f38dd::allahcat {
    struct ALLAHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALLAHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALLAHCAT>(arg0, 6, b"ALLAHCAT", b"MASHALLAH CAT", b"Faithful cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/55555_444cabcbcb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALLAHCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALLAHCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

