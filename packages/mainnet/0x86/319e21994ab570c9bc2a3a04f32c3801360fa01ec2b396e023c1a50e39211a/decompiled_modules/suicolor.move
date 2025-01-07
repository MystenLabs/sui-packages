module 0x86319e21994ab570c9bc2a3a04f32c3801360fa01ec2b396e023c1a50e39211a::suicolor {
    struct SUICOLOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICOLOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICOLOR>(arg0, 6, b"SUICOLOR", b"#4DA2FF Sea", x"5365610a0a4845583a20233444413246460a5247423a2037372f3136322f3235350a434d594b3a2036312f33302f3030", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_274_da526454ad.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICOLOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICOLOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

