module 0xdbdc869f5b72f2a2282bc7ae75d82bc64cd0e316d500b36c4de14377cf669b79::ida01 {
    struct IDA01 has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDA01, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDA01>(arg0, 6, b"IDA01", b"Riverside", x"4f726967696e616c204f696c205061696e74696e672063616c6c6564205269766572736964652062792049646120466561726e2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_12_at_18_05_25_bb9a1995a2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDA01>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IDA01>>(v1);
    }

    // decompiled from Move bytecode v6
}

