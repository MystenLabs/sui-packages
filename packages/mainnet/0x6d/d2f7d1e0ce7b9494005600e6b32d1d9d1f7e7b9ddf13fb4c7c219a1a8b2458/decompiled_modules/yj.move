module 0x6dd2f7d1e0ce7b9494005600e6b32d1d9d1f7e7b9ddf13fb4c7c219a1a8b2458::yj {
    struct YJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: YJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YJ>(arg0, 6, b"YJ", b"Yangjian", b"The Chinese ancient immortal Yangjian in his modern life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicowc43z6g7i5e3kjc7n5vu677jbqze3f4gkg74c5ls42vcgtteze")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YJ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

