module 0x7fa0e54c64490dde887db113dce1c459018de81862631d0522cf5bf689d95833::browsui {
    struct BROWSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROWSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROWSUI>(arg0, 6, b"BROWSUI", b"Browsui", b"$BROWSUI  is a token cryptocurrency used for accessing the internet and running web-based applications.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728668713286_e092ce5d21.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROWSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROWSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

