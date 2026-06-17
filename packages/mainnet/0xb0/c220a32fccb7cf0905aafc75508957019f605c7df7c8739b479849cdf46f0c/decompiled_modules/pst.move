module 0xb0c220a32fccb7cf0905aafc75508957019f605c7df7c8739b479849cdf46f0c::pst {
    struct PST has drop {
        dummy_field: bool,
    }

    fun init(arg0: PST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PST>(arg0, 4, b"PST", b"PST", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pre-vip.com/icon/pst.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PST>>(0x2::coin::mint<PST>(&mut v2, 21000000000, arg1), @0x7e98f1333ac573ba5dd795fa54528ab99e6b9d9086c07276d12df0bb20866d9a);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PST>>(v2);
    }

    // decompiled from Move bytecode v7
}

