module 0xf5717d85be56efe8e27bbc5883b5a0d9317c1e8f102f00d677f2ddb7e7b27ad6::airpod {
    struct AIRPOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRPOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIRPOD>(arg0, 6, b"AIRPOD", b"MY AIRPOD", b"Hey everyone, I just wanted to let you know that I lost my precious AirPod. If you happen to see it anywhere, please let me know! Thanks so much!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_04_143219_75a55dde8e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRPOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIRPOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

