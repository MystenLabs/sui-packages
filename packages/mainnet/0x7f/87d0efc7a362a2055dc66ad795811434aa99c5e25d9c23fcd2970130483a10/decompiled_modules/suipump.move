module 0x7f87d0efc7a362a2055dc66ad795811434aa99c5e25d9c23fcd2970130483a10::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, b"SuiPump", b"Sui Pump", b"SUI PUMP is a market-making bot designed to generate volume using fresh wallets to meet organic trend metrics on renowned charts like Dexscreener. Our technology ensures that the generated volume aligns with natural market movements, providing credibility", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_00_14_46_abff474b43.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

