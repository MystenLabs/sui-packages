module 0x9980c035ba9f4f5d0fa1f412be75c875b5086218069de349ea51212dcee6dda4::oneguyonejar {
    struct ONEGUYONEJAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEGUYONEJAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEGUYONEJAR>(arg0, 6, b"ONEGUYONEJAR", b"One guy One Jar", b"IF YOU KNOW, YOU KNOW. OH YES, ITS GONNA FIT, BUT YOURE GONNA PAY THE PRICE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1guy1jar_0276c56e4d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEGUYONEJAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONEGUYONEJAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

