module 0x5fdf494c264b9dce6193a7536ed04d17280f22d4e84003d0d68df2274a39e414::bbshark {
    struct BBSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBSHARK>(arg0, 6, b"BBshark", b"Baby Shark On Sui", b"The OFFICIAL Baby Shark On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeice5ejznlnk7vkt5i7xmx5aiuo3ceybggwuc57ccjyaoejkkdulwy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BBSHARK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

