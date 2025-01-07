module 0x68b7647aa123e9cde620df8be0d335516aff45fad124a702fe92e9514aa5830::spand {
    struct SPAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAND>(arg0, 6, b"SPAND", b"SUIPAND", b"SUI PANDA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suipanda_4ff3be1e40.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

