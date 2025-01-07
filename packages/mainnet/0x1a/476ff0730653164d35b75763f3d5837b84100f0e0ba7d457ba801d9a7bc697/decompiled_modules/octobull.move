module 0x1a476ff0730653164d35b75763f3d5837b84100f0e0ba7d457ba801d9a7bc697::octobull {
    struct OCTOBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTOBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTOBULL>(arg0, 6, b"OCTOBULL", b"OCTOBULL ON SUI", x"244f43544f42554c4c2069732074686520756c74696d617465206d656d6520746f6b656e20646f6d696e6174696e67205355492074686973204f63746f62657221200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b_Pgx_Ruq_400x400_3e08a3cc10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTOBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

