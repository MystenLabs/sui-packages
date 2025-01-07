module 0x9dcb0087b0eeb9ebb352f3cfe8f0e9a5a0abea18396b85e0193d76e3a7a032e4::xxxcat {
    struct XXXCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXXCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XXXCAT>(arg0, 6, b"XXXCAT", b"XXX CAT", b"OMFG I'M CUMMING FOR SUI! I CAN'T STOP!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_8ecff42602.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXXCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XXXCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

