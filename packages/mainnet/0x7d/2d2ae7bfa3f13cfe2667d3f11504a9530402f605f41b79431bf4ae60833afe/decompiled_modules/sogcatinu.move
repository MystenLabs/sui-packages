module 0x7d2d2ae7bfa3f13cfe2667d3f11504a9530402f605f41b79431bf4ae60833afe::sogcatinu {
    struct SOGCATINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOGCATINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOGCATINU>(arg0, 6, b"SogCatInu", b"SealDogAAACatInu", x"5365616c202b20446f67202b20436174202b20494e55203d204d4f4f4e0a4e6f20736f6369616c732e20436f6d6d756e6974792073686f756c642072756e2e20446576206a757374206c61756e636865732e2043544f20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003621_70ebab2b1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOGCATINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOGCATINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

