module 0xe561e8f7678b47965d8a8c1b8ea698807e57c5560be2e5b1b0644ea5de764a18::bls {
    struct BLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLS>(arg0, 6, b"BLS", b"BUMLEESUI", b"\"Buzzz... Hello future investors! BUMLEE here, the honey and money making expert!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_6f80117cb0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

