module 0x5a20e00c6afc14db7cb2c6203ac5b119bdac0f079105c6975d736b0a93e1d2ee::xandao {
    struct XANDAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XANDAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XANDAO>(arg0, 6, b"Xandao", b"fuck Xandao", b"Alexandre de Morais is a Brazilian judge who abuses his power to censor and oppress the Brazilian people. This caught the attention of the giant Elon Musk, who is trying to combat the tyranny of Xadao, as he is called.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xadao_13de213183.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XANDAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XANDAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

