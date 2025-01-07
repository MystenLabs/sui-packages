module 0xee313dfe459680718ebda4903f639d70f8f78d6bf81e98dd596441c53ba8e894::freedogx {
    struct FREEDOGX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREEDOGX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREEDOGX>(arg0, 6, b"FREEDOGX", b"FreeDogX", b"The 'FreeDogX' project builds a campaign that blends the theme of freedom for Pavel Durov, the founder of Telegram, with the symbols 'Dog' and 'X.' The project highlights Durovs unjust detention, using 'Dog' to symbolize loyalty and 'X' to represent a decentralized future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_Hyy_I7ft_400x400_456dc4b6e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREEDOGX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREEDOGX>>(v1);
    }

    // decompiled from Move bytecode v6
}

