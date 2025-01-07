module 0xca9d3d627e86b69a95339fbb794e2a6d764a4be93c6f1d3a979c7e7e001914f7::billions {
    struct BILLIONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLIONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLIONS>(arg0, 6, b"BILLIONS", b"$BILLIONS", x"242042696c6c696f6e7320240a0a5374657020313a204b4f545320284b696e67206f662074686520536561290a2d2054656c656772616d204368617420756e6c6f636b65640a2d2d2044455873637265656e657220507265706169640a2d2d2d204368657272795472656e64696e670a2d2d2d2d2050756d70626f74730a2d2d2d2d2d20536d616c6c2063616c6c65720a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d203f2025204275726e0a0a5374657020323a20283130302520426f6e64696e67204375727665290a2d2031303020456e6572677920426f6f7374206f6e206465780a2d2d20446578204144530a2d2d2d20535549205472656e64696e670a2d2d2d2d204269672063616c6c65720a2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d2d203f2025204275726e0a0a242042696c6c696f6e7320240a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Billions_pf_2c8ec01bf2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLIONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BILLIONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

