module 0xb4fd3257b7477d56d02a3381f7e6c24651d9d56f0e371d088b7e7743c79c7805::dacat {
    struct DACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DACAT>(arg0, 6, b"DACAT", b"Default Cat", b"Default Cat, origin of all cat memecoins, they all started as a default pfp, and they were cats so default + cat = default cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gif2_9cfa3b3ff9_874004c316.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

