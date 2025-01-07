module 0xa56ab6379d142874f71165436df1f578ed77fad7d46c575a79dbfcc048760b73::fisher {
    struct FISHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHER>(arg0, 6, b"FISHER", b"Just a chill fisherm", x"4865e2809973206f75742068657265206f6e2074686520537569204f6365616e2c20726f6420696e2068616e642c206361746368696e6720616c6c2074686520666973686573206f6e20686973206a6f75726e65792e20457665727920636173743f2053747261696768742070756c6c696e672075702062696720636174636865732c20616e64207472757374206d652c20626967207468696e6773206172652061626f757420746f20676f20646f776e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735908551131.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

