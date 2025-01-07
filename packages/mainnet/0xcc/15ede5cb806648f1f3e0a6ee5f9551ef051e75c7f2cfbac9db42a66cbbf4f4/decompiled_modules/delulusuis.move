module 0xcc15ede5cb806648f1f3e0a6ee5f9551ef051e75c7f2cfbac9db42a66cbbf4f4::delulusuis {
    struct DELULUSUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELULUSUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELULUSUIS>(arg0, 6, b"DELULUSUIS", b"DELULUSUI", b"DELULU ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_213549653_fa0c5ba9b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELULUSUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DELULUSUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

