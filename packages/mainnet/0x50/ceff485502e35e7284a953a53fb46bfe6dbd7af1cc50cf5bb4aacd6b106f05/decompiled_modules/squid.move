module 0x50ceff485502e35e7284a953a53fb46bfe6dbd7af1cc50cf5bb4aacd6b106f05::squid {
    struct SQUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUID>(arg0, 6, b"Squid", b"SQUID", b"Marine creatures, king of squid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_e_25150d14a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

