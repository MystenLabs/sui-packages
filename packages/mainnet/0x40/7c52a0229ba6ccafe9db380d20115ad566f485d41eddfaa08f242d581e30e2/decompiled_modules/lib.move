module 0x407c52a0229ba6ccafe9db380d20115ad566f485d41eddfaa08f242d581e30e2::lib {
    struct LIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIB>(arg0, 6, b"Lib", b"Screaming Lib", b"Make this Liberal scream again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Luke_Crywalker_Main_01_00480_1000x563_3d673eb749.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

