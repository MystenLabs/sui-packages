module 0xf969a73da86e036cfd4394463b59f953da6e9c67f88fdfd09ecdf357984cf53b::iq50 {
    struct IQ50 has drop {
        dummy_field: bool,
    }

    fun init(arg0: IQ50, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IQ50>(arg0, 6, b"IQ50", b"IQ 50", b"Analyzing No Sense, IQ50 Be Rich ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_62380_5b05d97d44.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IQ50>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IQ50>>(v1);
    }

    // decompiled from Move bytecode v6
}

