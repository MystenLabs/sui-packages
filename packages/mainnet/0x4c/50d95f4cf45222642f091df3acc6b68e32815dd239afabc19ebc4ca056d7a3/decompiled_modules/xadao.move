module 0x4c50d95f4cf45222642f091df3acc6b68e32815dd239afabc19ebc4ca056d7a3::xadao {
    struct XADAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XADAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XADAO>(arg0, 6, b"Xadao", b"Fuck Xadao", b"Alexandre de Morais is a Brazilian judge who abuses his power to censor and oppress the Brazilian people. This caught the attention of the giant Elon Musk, who is trying to combat the tyranny of Xadao, as he is called.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xadao_c8facb7c68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XADAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XADAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

