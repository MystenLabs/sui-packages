module 0x7d3f3af8c9482a8419e73ae104cf9800752f6ee87987a6c67ce67fb98365a3f7::sapes {
    struct SAPES has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPES>(arg0, 6, b"SAPES", b"SUI APES", b"First ape on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3523_a33502446b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAPES>>(v1);
    }

    // decompiled from Move bytecode v6
}

