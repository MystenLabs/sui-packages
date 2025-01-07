module 0x2070b656528466e545f4ade84fb76fe7c22b64d9cb90379784a70fc06b69e16c::puccki {
    struct PUCCKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUCCKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUCCKI>(arg0, 6, b"Puccki", b"Puccy Kitty ", x"57686fe280997320726561647920746f2068616e646c652074686973206669657279206b6974747920696e2074686569722077616c6c65743f20f09f988ff09f90be0a0a4c6f7665733a204d69646e69676874206d6973636869656620f09f8c992c20737465616c696e6720617474656e74696f6e20f09f94a52c20697272657369737469626c6520707572727320f09f98bd0a0a566962653a2053776565742c2073617373792c20616e64206120626974206e61756768747920f09f98880a0a4d6f74746f3a202241646f7265206d65e280a620696620796f752063616e2068616e646c6520697420f09f988f220a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731233764445.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUCCKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUCCKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

