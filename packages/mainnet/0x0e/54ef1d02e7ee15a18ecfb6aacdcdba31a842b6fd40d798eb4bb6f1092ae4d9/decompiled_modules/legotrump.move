module 0xe54ef1d02e7ee15a18ecfb6aacdcdba31a842b6fd40d798eb4bb6f1092ae4d9::legotrump {
    struct LEGOTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGOTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGOTRUMP>(arg0, 6, b"LEGOTRUMP", b"Lego Trump", b"Meet LEGOTRUMP, The only coin where Trump builds his own wall, one brick at a time. No instructions needed!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1b015904a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGOTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEGOTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

