module 0xc4b9cebd8c1801465776ed7bc07373d8fa004521a9347dab942102b0f7e6cc2b::gecko {
    struct GECKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GECKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GECKO>(arg0, 6, b"Gecko", b"Gecko OnSui", x"746865206f6666696369616c20746f6b656e206f6620746865200a406765636b6f736f6e736f6c0a2065636f73797374656d207c20706f7765726564206279200a4077617463686d616e0a207c206c61756e6368696e67206f6e2024535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/QYX_Ic_Ur_U_400x400_bbe1b49495.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GECKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GECKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

