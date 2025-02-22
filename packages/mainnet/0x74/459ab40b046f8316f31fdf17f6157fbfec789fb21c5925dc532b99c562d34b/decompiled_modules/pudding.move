module 0x74459ab40b046f8316f31fdf17f6157fbfec789fb21c5925dc532b99c562d34b::pudding {
    struct PUDDING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDDING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDDING>(arg0, 9, b"Pudding", b"Pudding Coin", b"Pudding, an adorable Corgi, came into this world in 2024. With his signature short legs, round butt, and ever-curious eyes, he quickly became the brightest star in my life. Pudding is not just a pet; he is family, accompanying me through countless moments of joy and hardship.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/82d3326f340ad67fa8ab2e91350884cablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUDDING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDDING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

