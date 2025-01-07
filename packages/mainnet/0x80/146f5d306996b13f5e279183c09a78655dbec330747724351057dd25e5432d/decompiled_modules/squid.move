module 0x80146f5d306996b13f5e279183c09a78655dbec330747724351057dd25e5432d::squid {
    struct SQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUID>(arg0, 6, b"SQUID", b"Handsome Squidward", b"He's absolutely stunning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_9dd7caefef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

