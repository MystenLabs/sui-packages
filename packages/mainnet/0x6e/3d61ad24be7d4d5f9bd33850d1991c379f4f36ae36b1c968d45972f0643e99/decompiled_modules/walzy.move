module 0x6e3d61ad24be7d4d5f9bd33850d1991c379f4f36ae36b1c968d45972f0643e99::walzy {
    struct WALZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALZY>(arg0, 6, b"WALZY", b"Walzy", x"486573206f75742068657265206f6e2074686520537569204f6365616e2c20726f6420696e2068616e642c206361746368696e6720616c6c2074686520666973686573206f6e20686973206a6f75726e65792e20457665727920636173743f2053747261696768742070756c6c696e672075702062696720636174636865732c20616e64207472757374206d652c20626967207468696e6773206172652061626f757420746f20676f20646f776e2e0a0a546869732061696e74206a7573742066697368696e673b2069747320612077686f6c652076696265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250508_024319_899_9e30cd1481.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

