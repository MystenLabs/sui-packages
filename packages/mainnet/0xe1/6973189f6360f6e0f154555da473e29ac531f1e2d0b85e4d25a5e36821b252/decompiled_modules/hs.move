module 0xe16973189f6360f6e0f154555da473e29ac531f1e2d0b85e4d25a5e36821b252::hs {
    struct HS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HS>(arg0, 6, b"HS", b"Homer Sui", x"486f6d65722050756d702069740a4c666720686f6d657220666f72204d6f6f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/homer_edit_6b3ab64ae0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HS>>(v1);
    }

    // decompiled from Move bytecode v6
}

