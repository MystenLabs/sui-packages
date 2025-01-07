module 0xc8b57710aa225c859ab1a393f2679370592439c7b6840787d60114b28dbad83d::neui {
    struct NEUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEUI>(arg0, 6, b"NEUI", b"Neuroinu", x"49276d20746865206669727374206b696e64206f66206d696e6520696e20746865204e6575726f6e7320696e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_03_04_11_03_47_f5ee82d3a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

