module 0x3a9e7ecea1b65514d03f435f145b7233b98571564b9543cdff934cfb16dbe548::sui3141 {
    struct SUI3141 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI3141, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI3141>(arg0, 6, b"SUI3141", b"Sui3141", x"5468657920646f75627465642075732e0a546865792069676e6f7265642075732e0a427574202453554933313431207761732061626f757420746f2072657772697465207468652072756c65732e0a4e6f206f6e652077617320707265706172656420666f7220776861742077617320636f6d696e672e0a54686520736b793f20497420776173206a7573742074686520626567696e6e696e672e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069597_dfa30bb5f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI3141>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI3141>>(v1);
    }

    // decompiled from Move bytecode v6
}

