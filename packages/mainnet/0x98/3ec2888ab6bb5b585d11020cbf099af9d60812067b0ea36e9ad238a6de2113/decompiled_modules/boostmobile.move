module 0x983ec2888ab6bb5b585d11020cbf099af9d60812067b0ea36e9ad238a6de2113::boostmobile {
    struct BOOSTMOBILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOSTMOBILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOSTMOBILE>(arg0, 6, b"BOOSTMOBILE", b"Boost Mobile", b"https://www.reddit.com/r/adultswim/comments/14ccu9a/boost_mobile_shake_lol/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihxtwohlgpdybohpiq5p6pwbdu6up2qrto6x2hb2yjy22y2ao2hom")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOSTMOBILE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOOSTMOBILE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

