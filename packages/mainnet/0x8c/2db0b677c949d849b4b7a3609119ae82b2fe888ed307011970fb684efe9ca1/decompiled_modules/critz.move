module 0x8c2db0b677c949d849b4b7a3609119ae82b2fe888ed307011970fb684efe9ca1::critz {
    struct CRITZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRITZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRITZ>(arg0, 6, b"CRITZ", b"CRITZ COIN", x"41206d656e616765726965206f66204372697474657273207265736964696e67206f6e20746865200a405375690a20626c6f636b636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_Thk_Vu_UF_400x400_17f56af6b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRITZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRITZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

