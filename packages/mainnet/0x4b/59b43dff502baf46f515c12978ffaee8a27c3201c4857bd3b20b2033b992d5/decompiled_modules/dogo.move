module 0x4b59b43dff502baf46f515c12978ffaee8a27c3201c4857bd3b20b2033b992d5::dogo {
    struct DOGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGO>(arg0, 6, b"DOGO", b"Dogo", b"$DOGO is the coolest dog on the Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ppp_b37108881d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

