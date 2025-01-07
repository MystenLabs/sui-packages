module 0xace9f6b5d53bed0d0ff0f4bcecdd81cf185316230cbac7e297d26394330f22fc::puccycat {
    struct PUCCYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUCCYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUCCYCAT>(arg0, 6, b"Puccycat", b"Puccy cat", x"57686fe280997320726561647920746f2068616e646c652074686973206669657279206b6974747920696e2074686569722077616c6c65743f20f09f988ff09f90be0a0a4c6f7665733a204d69646e69676874206d6973636869656620f09f8c992c20737465616c696e6720617474656e74696f6e20f09f94a52c20697272657369737469626c6520707572727320f09f98bd0a0a566962653a2053776565742c2073617373792c20616e64206120626974206e61756768747920f09f98880a0a4d6f74746f3a202241646f7265206d65e280a620696620796f752063616e2068616e646c6520697420f09f988f220a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731170857652.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUCCYCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUCCYCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

