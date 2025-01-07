module 0x68677051136338ebdd8a1c51f3d6edae03cd41f7e0ac63cb6e9012883348b42a::ronnie {
    struct RONNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONNIE>(arg0, 6, b"RONNIE", b"RONNIE SUI", b"Gangster princes. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ny03ra_LX_400x400_7bc306d941.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONNIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONNIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

