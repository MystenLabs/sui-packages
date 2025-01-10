module 0x1d2ff780d6a986e45af2f0a65436313c773c6a8eb34716d461af89d3ae4f664d::froggo {
    struct FROGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGO>(arg0, 6, b"FROGGO", b"Fisherman's Frog", x"46524f47474f2c2074686520226c75636b696573742066726f6720616c6976652c222077617320666f756e6420696e7369646520612070657263682773206d6f7574682062792041757373696520616e676c657220416e677573204a616d65732e204865206c656170656420746f2066726565646f6d20616e6420626563616d65206120766972616c206d656d6520737461722120f09f90b8e29ca8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736511868645.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROGGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

