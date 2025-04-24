module 0x78b1b71dd108d9bf1c6fdbfbb048af4594c1ebc0aa10f38b723b8f1394a5edb8::asslive {
    struct ASSLIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSLIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSLIVE>(arg0, 6, b"AssLive", b"Anal Live", b"https://twitchs.cam/AnalSex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiejq5ht5acw5a7yk2sgpizfbs54p6kawssptmfi7ozyaf3s67t3ey")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSLIVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASSLIVE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

