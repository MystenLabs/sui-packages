module 0xdac412b846cef28f83dd4338f95e681f300ab4b7ba9ced17d84809cf7f03ea06::fcat {
    struct FCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCAT>(arg0, 6, b"FCAT", b"FxckCaTSui", x"4678636b2049742c204678636b207468652063686172742c204678636b205375692c204678636b2070756d70730a0a49276d20726561647920746f206675636b207468697320736869742075702e0a0a2446434154", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/favicon2_7d51715a84.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

