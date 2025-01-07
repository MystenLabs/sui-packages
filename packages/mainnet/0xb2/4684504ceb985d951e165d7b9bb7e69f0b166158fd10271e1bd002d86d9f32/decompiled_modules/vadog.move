module 0xb24684504ceb985d951e165d7b9bb7e69f0b166158fd10271e1bd002d86d9f32::vadog {
    struct VADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: VADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VADOG>(arg0, 6, b"VADOG", b"Bark Vadog", x"4c61756e63686564206f6e206d6f6f6e73686f742e0a5265642d457965642c204f7665726c6f7264206f662043616e6f706975732c204173706972696e67204d6f6f6e204d6f6e617263682e20447265616d733a2041206c756e6172206573746174652020536b696c6c73203a204c6967687473616265722068616e646c696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dufh_C63_V_400x400_da0e04c7aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

