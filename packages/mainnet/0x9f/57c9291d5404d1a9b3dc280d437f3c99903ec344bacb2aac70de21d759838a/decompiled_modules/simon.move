module 0x9f57c9291d5404d1a9b3dc280d437f3c99903ec344bacb2aac70de21d759838a::simon {
    struct SIMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMON>(arg0, 6, b"SIMON", b"Simon On SUI", x"486f6e6f7261727920446f67204d61796f722c20456c6563746564206279207468652070656f706c652c20666f72207468652070656f706c652e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SH_8_L_Yuwj_400x400_1dd092e77c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

