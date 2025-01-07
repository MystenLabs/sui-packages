module 0x8f5daa8f4a292b2f3c135a8a7bbe0ebd7eaec2456f5b65522d0b078d20f5d5c7::liq {
    struct LIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQ>(arg0, 6, b"LIQ", b"Liquor", x"466f726765742074686174207765616b2d617373204c6971756f7220636f696e2c2077652772652061626f757420746f20676574205455524e54207769746820244641495253484f5421200a0a546869732061696e277420796f757220617665726167652072756770756c6c2c2070617065722d68616e6465642077696d7073212057652772652074616c6b696e2720626f757420612046414952204c41554e43482074686174276c6c206d616b6520746865204f47204c6971756f72206c6f6f6b206c696b6520776174657265642d646f776e20706973732120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_H_E2_Fq_E_400x400_1c6babe455.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

