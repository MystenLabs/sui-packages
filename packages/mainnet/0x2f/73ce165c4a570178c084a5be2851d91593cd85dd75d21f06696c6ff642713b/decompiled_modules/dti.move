module 0x2f73ce165c4a570178c084a5be2851d91593cd85dd75d21f06696c6ff642713b::dti {
    struct DTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTI>(arg0, 6, b"DTI", b"Dress to Impress on SUI", x"447265737320746f20696d707265737320686173206f76657220332e362042696c6c696f6e20706c61797320616e6420314d2061637469766520706c61796572732e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_T5l_V_Vg_400x400_9f8e68ce63.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

