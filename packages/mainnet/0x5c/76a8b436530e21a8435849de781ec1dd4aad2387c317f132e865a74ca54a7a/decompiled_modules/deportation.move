module 0x5c76a8b436530e21a8435849de781ec1dd4aad2387c317f132e865a74ca54a7a::deportation {
    struct DEPORTATION has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEPORTATION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEPORTATION>(arg0, 6, b"DEPORTATION", b"Campaign For Deportation From America", b"The official and only commemorative coin to support the Articulate Madness campaign for deportation from America.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A8_M_Coin_250x250_6ff2bf7b4f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEPORTATION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEPORTATION>>(v1);
    }

    // decompiled from Move bytecode v6
}

