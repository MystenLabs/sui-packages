module 0x3dc850704a8e46d47ee670737d7b30986026dea8da8f246bbcb1ef7367c3486a::oni {
    struct ONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONI>(arg0, 6, b"ONI", b"Onigiri", b"Kabosu and Neiro's favourite brother", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yyv52_Ar_J_400x400_56419076c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

