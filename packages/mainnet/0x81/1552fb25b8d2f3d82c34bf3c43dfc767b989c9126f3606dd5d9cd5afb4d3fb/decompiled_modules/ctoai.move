module 0x811552fb25b8d2f3d82c34bf3c43dfc767b989c9126f3606dd5d9cd5afb4d3fb::ctoai {
    struct CTOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTOAI>(arg0, 9, b"CTOAI", b"ClustroAI", b"ClustroAI is dedicated to advancing edge AI through containerized architectures, GPU acceleration, and scalable computing frameworks. By optimizing AI protocols for distributed environments, ClustroAI ensures low-latency processing and seamless deployment, powering the next generation of AI-driven applications.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWXTmhg1ZUAm3u9uFbUWjnTTbhG5dKyiECVsUzxZnNL3X")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CTOAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTOAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTOAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

