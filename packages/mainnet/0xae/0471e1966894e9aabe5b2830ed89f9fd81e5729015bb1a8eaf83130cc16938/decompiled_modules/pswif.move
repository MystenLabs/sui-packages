module 0xae0471e1966894e9aabe5b2830ed89f9fd81e5729015bb1a8eaf83130cc16938::pswif {
    struct PSWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSWIF>(arg0, 6, b"PSWIF", b"PixelSuiWifHat", b"just a cool droplet of water wif hat on the sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733538794670.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSWIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

