module 0xad9bcdb63e1fbfd0885f69f2aa02bd96b5018e023c2fe7ac26aba7be1fdcfa8c::wofl {
    struct WOFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOFL>(arg0, 6, b"WOFL", b"Wofl On SUI", b"Wofl, the cousin of Pepe, is a mysterious trickster who roams the digital wilderness, always stirring up mischief.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asd2312zxczxcbvcvbn_a01a323b57.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOFL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOFL>>(v1);
    }

    // decompiled from Move bytecode v6
}

