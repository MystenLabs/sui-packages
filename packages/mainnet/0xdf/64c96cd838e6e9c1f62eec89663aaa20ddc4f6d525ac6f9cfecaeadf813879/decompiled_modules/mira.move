module 0xdf64c96cd838e6e9c1f62eec89663aaa20ddc4f6d525ac6f9cfecaeadf813879::mira {
    struct MIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIRA>(arg0, 6, b"MIRA", b"MIRA ON SUI", b"if you could press a button that cures your childs brain tumor in exchange for ending your life immediately, every parent would hesitate for zero seconds before fighting to be the first to press it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007466_3bf544f6f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

