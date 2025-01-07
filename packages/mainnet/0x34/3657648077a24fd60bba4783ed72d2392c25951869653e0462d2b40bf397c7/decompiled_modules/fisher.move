module 0x343657648077a24fd60bba4783ed72d2392c25951869653e0462d2b40bf397c7::fisher {
    struct FISHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHER>(arg0, 9, b"FISHER", b"FISHER", x"4865e2809973206f75742068657265206f6e2074686520537569204f6365616e2c20726f6420696e2068616e642c206361746368696e6720616c6c2074686520666973686573206f6e20686973206a6f75726e65792e20457665727920636173743f2053747261696768742070756c6c696e672075702062696720636174636865732c20616e64207472757374206d652c20626967207468696e6773206172652061626f757420746f20676f20646f776e2e20546869732061696ee2809974206a7573742066697368696e673b206974e280997320612077686f6c6520766962652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1861363398291984384/QmbW9QMZ_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FISHER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FISHER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHER>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

