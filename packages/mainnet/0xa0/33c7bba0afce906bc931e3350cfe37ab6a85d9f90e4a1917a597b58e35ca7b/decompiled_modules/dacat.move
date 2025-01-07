module 0xa033c7bba0afce906bc931e3350cfe37ab6a85d9f90e4a1917a597b58e35ca7b::dacat {
    struct DACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DACAT>(arg0, 6, b"DACAT", b"Default Cat", b"Default Cat, origin of all cat memecoins, they all started as a default pfp, and they were cats so default + cat = default cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gif2_b3a1ec1120.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

