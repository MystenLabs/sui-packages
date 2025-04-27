module 0x21abaa88dc576e051eb22ada5d6c64e492b471bcbf9ff9215982b5c736335309::motion {
    struct MOTION has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTION>(arg0, 6, b"Motion", b"Motion Community", x"4a7573742073686f77696e6720796f7520677579732e0a0a5669626520746f6b656e20776974682061207075726520646567656e20636f6d6d756e697479203e20612066756e646564206c61756e63682066726f6d207375636b6d616469636b2041492073747564696f2e0a0a54686973206d61726b65742068617320616c77617973206265656e2061626f757420636f6d6d756e69747920616e64207472756520646567656e732e20446f6ee2809974206265206e6f726d6965732c20646f6ee28099742067657420727567676564206f6e206e6f726d696520636f696e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1745794546854.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOTION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

