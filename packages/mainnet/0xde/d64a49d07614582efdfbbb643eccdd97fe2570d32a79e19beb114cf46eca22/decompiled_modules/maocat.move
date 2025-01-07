module 0xded64a49d07614582efdfbbb643eccdd97fe2570d32a79e19beb114cf46eca22::maocat {
    struct MAOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAOCAT>(arg0, 6, b"MAOCAT", b"MaoCat Sui", b"My plan is to take over  world,  not sure how or way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001642_f951d01a54.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

