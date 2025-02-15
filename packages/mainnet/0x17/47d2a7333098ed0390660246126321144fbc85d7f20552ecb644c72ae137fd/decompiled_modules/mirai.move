module 0x1747d2a7333098ed0390660246126321144fbc85d7f20552ecb644c72ae137fd::mirai {
    struct MIRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIRAI>(arg0, 6, b"MIRAI", b"Mirai On Sui", x"4d4952414920697320616c736f206120756e697175652065636f73797374656d20776865726520414920616e64207468650a636f6d6d756e69747920646576656c6f7020616e64206372656174652076616c756520746f676574686572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Efour_Digital_Pro_4_bb116b1037.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIRAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIRAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

