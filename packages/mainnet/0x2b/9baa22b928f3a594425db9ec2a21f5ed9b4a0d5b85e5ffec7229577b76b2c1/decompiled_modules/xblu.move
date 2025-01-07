module 0x2b9baa22b928f3a594425db9ec2a21f5ed9b4a0d5b85e5ffec7229577b76b2c1::xblu {
    struct XBLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: XBLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XBLU>(arg0, 6, b"XBLU", b"XBLUE", b"Verified Badge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L_12_db01b995b1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XBLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

