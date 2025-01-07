module 0xd6059ea4b20c9ec2f48585c97f0284b85fc42771ad17a787b1ee258f52f8bd7f::myke {
    struct MYKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYKE>(arg0, 6, b"MYKE", b"MYKE TYTHON", x"4d594b4520545954484f4e2041494e54204c4f53494e4720544f2053554d204c494c205554554245204b49440a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731642486956.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

