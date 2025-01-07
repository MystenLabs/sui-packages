module 0x739ef189451fbf27cbdbc0e42d2239348e633115c3b5d98775757e4e35102fc4::baksui {
    struct BAKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKSUI>(arg0, 6, b"BAKSUI", b"BAKSO ON SUI", b"FIRST LOOK  Meet two-week old, Bakso, the newest Sumatran tiger cub at Disneys Animal Kingdom  http://di.sn/6009qrgcP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/baksui_b32eedb133.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

