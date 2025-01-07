module 0x7862331bfaed74c098759cf048cb8934bfe8b758d42159750654185ba0897924::penut {
    struct PENUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENUT>(arg0, 6, b"PENUT", b"First Pepeanut on Sui", b"First Pepeanut on Sui: pepeanutonsui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_33_19e74459fc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

