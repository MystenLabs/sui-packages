module 0x99c0f48a7474a6b62edff58ccbcb6d6b9b81ac1d159d7e3d41e9745e723291a3::birdog {
    struct BIRDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDOG>(arg0, 6, b"BIRDOG", b"BirdDog Sui", b"$DOGBIRD IS A MEME COIN ON SUI BLOCKCHAIN WITH NEW FEATURE AND UTILITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000236_3b2abf8e0c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

