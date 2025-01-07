module 0x50a3e4cff199332c9c227eedddd3a865dd1990c9d069c59bea6a36bf81906981::popo {
    struct POPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPO>(arg0, 6, b"Popo", b"Popo the dogs", x"57656c636f6d6520746f2074686520506f706f2066616d696c79206d616b652074686520506f706f206b696c6c656420646f67776966202c207765206e6f74207769662077652061726520506f706f2074686520646f67732020200a0a706f706f2074686973206d656d6520746f6b656e206f6e2073756920636861696e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/popodogs_cba3adef5d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

