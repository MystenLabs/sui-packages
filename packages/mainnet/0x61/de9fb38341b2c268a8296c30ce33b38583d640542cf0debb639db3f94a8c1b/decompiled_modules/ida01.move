module 0x61de9fb38341b2c268a8296c30ce33b38583d640542cf0debb639db3f94a8c1b::ida01 {
    struct IDA01 has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDA01, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDA01>(arg0, 6, b"IDA01", b"Riverside", x"4f726967696e616c204f696c205061696e74696e672063616c6c6564205269766572736964652062792049646120466561726e2e200a0a5265616c20776f726c64206172742e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_12_at_18_05_25_bb9a1995a2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDA01>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IDA01>>(v1);
    }

    // decompiled from Move bytecode v6
}

