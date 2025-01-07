module 0x7ac6e6d7afc2b3659d8bf43aaf08c60ee852f2973be8240f1e64751c4e67b741::cbwm {
    struct CBWM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBWM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBWM>(arg0, 6, b"CBWM", b"Cat Black White Meme", b"Cat cute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000064120_2414efbc4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBWM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBWM>>(v1);
    }

    // decompiled from Move bytecode v6
}

