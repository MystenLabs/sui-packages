module 0x9025f5be47b2631fdf945487ede04467af89ed86603a159e71fc0dbd1ba9d0fc::frankensonny {
    struct FRANKENSONNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRANKENSONNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRANKENSONNY>(arg0, 6, b"FrankenSonny", b"FrankenSon", x"416d204920616c6976652c206f72206a757374206120736861646f77206f662074776f20776f726c647320746861742073686f756c64206e657665722068617665206d65743f0a536f6e6e79206d65657473204672616e6b656e737465696e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D0988544_6617_4_DEB_B175_B12_AC_38_D74_C4_a18565b28a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRANKENSONNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRANKENSONNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

