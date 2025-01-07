module 0x8f18d52ef5af9eda3f99cf484b23e4fc98b23840dc06afb50328e9f11d62726f::suiton {
    struct SUITON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITON>(arg0, 6, b"SUITON", b"SUI TON", b"The suiton meme on Sui playfully turns blockchain transactions into epic Naruto style water release jutsu, as if sending token is as dramatic as unleashing a tidal wave.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUITON_56233f4b2a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITON>>(v1);
    }

    // decompiled from Move bytecode v6
}

