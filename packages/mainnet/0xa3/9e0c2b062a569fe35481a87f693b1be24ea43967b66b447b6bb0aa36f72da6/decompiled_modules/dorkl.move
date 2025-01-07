module 0xa39e0c2b062a569fe35481a87f693b1be24ea43967b66b447b6bb0aa36f72da6::dorkl {
    struct DORKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORKL>(arg0, 6, b"DORKL", b"DorkLord", b"This is DorkLord the commander of all sui memes, enjoy the ride with us ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_78_8a50cc2480.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

