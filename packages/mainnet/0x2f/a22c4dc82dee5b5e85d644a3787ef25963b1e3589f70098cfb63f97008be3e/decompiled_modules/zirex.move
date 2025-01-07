module 0x2fa22c4dc82dee5b5e85d644a3787ef25963b1e3589f70098cfb63f97008be3e::zirex {
    struct ZIREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIREX>(arg0, 6, b"ZIREX", b"zirex", x"247a69726578207468650a626f78696e6720647261676f6e21205468650a6669727374206f6620697473206b696e642c0a6c616e64696e67206f6e2074686520626173650a6e6574776f726b21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_00_45_20_a99fd4bf9b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZIREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

