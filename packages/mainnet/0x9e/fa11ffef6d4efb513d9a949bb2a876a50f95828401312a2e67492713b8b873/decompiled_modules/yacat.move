module 0x9efa11ffef6d4efb513d9a949bb2a876a50f95828401312a2e67492713b8b873::yacat {
    struct YACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YACAT>(arg0, 6, b"YACAT", b"YAKUZA CAT", b"YAKUZA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4915764682623659451_f8d4016f72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

