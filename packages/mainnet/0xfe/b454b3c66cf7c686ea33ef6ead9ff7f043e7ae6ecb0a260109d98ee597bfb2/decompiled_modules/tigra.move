module 0xfeb454b3c66cf7c686ea33ef6ead9ff7f043e7ae6ecb0a260109d98ee597bfb2::tigra {
    struct TIGRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGRA>(arg0, 6, b"Tigra", b"Tigra Vitaliks Cat", b"Join the fun with $TIGRA, the meme coin inspired by Vitalik Buterin's legendary cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3p_v2_Vl_P_400x400_e3a8d2e6d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIGRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

