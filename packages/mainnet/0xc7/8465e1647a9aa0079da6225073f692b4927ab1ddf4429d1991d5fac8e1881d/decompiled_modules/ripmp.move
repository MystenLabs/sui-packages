module 0xc78465e1647a9aa0079da6225073f692b4927ab1ddf4429d1991d5fac8e1881d::ripmp {
    struct RIPMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIPMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIPMP>(arg0, 6, b"RIPMP", b"R.I.P MovePump", b"This is MovePump's last token, RIP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004247_3862c0af35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIPMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIPMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

