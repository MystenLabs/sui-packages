module 0xdf400e1393f07072f5e1bee7bb7ffcdaeaad6a58a3b528aaad06ae5c90d3556b::one000000000 {
    struct ONE000000000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE000000000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE000000000>(arg0, 6, b"One000000000", b"Neiro 0n Sui", b"Asia's most beloved dog is now available at Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022350_004ef984d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE000000000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONE000000000>>(v1);
    }

    // decompiled from Move bytecode v6
}

