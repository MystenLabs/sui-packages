module 0x1a7a0b502fc35a6e6d974da16effee1bdeec17b0e3f7507e2326c533d6bccec1::kuaisusui {
    struct KUAISUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUAISUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUAISUSUI>(arg0, 6, b"KUAISUSUI", b"KUAISU SUI", b"Ride the wave of Kuaisu!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_165413813_c2480357ee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUAISUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUAISUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

