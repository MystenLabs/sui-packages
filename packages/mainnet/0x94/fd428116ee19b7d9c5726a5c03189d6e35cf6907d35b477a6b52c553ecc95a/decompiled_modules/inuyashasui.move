module 0x94fd428116ee19b7d9c5726a5c03189d6e35cf6907d35b477a6b52c553ecc95a::inuyashasui {
    struct INUYASHASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: INUYASHASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INUYASHASUI>(arg0, 6, b"INUYASHASUI", b"Inuyasha", b"https://x.com/InuyashaSui  https://t.me/+ifDAj_pnKrRiYzc1  https://www.reddit.com/r/inuyasha/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/p185776_b_v8_ad_b2727806b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INUYASHASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INUYASHASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

