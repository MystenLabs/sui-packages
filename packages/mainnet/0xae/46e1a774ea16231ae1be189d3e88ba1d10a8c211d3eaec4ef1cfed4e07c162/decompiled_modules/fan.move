module 0xae46e1a774ea16231ae1be189d3e88ba1d10a8c211d3eaec4ef1cfed4e07c162::fan {
    struct FAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAN>(arg0, 9, b"FAN", b"MEME FAN", b"meme fan token on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.app.goo.gl/CjXontH5vxBF6tzZ9")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FAN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

