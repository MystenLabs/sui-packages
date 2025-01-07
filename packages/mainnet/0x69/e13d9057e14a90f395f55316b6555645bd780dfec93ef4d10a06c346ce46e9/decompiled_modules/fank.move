module 0x69e13d9057e14a90f395f55316b6555645bd780dfec93ef4d10a06c346ce46e9::fank {
    struct FANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FANK>(arg0, 6, b"FANK", b"FANKS", x"46616e6b732069732074686520656d626f64796d656e74206f662066617374666f6f64206275726765727320666f7220616c6c207468652062757267657220616e642066617374666f6f64206c6f76657273206f7574207468657265210a496620796f75206c696b65206275726765727320796f752073686f756c64206c696b652066616e6b7320746f6f2121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Log_A_a73a58cbe7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

