module 0xc816a9110219152e7b93fc7dd8d6c624bf89f90c7fd3e7bf36ba60ce898c218e::koisui {
    struct KOISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOISUI>(arg0, 6, b"KOIsui", b"KOI", x"4120426f6c642046697368204d616b696e67205761766573206f66205765616c746820696e2074686520537569204f6365616e200a405375694e6574776f726b0a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/koin_soi_b4521f4bd4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

