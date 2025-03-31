module 0xd6ce8ccab0b674d9068e8effbfe57d8a6bf3ed63c96554efcb4a869033ab5a5d::lezui {
    struct LEZUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEZUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEZUI>(arg0, 6, b"LEZUI", b"Lezui", b"Lezui is a big memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052611_3aafdc17b2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEZUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEZUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

