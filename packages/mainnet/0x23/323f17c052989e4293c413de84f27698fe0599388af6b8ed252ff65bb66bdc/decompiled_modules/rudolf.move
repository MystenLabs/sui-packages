module 0x23323f17c052989e4293c413de84f27698fe0599388af6b8ed252ff65bb66bdc::rudolf {
    struct RUDOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUDOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUDOLF>(arg0, 6, b"RUDOLF", b"Rudolf the Younger", b"Rudolf the Younger (????-1306); son of the Duke and Duchess of Austria, Rudolf III and Blanche of France. Original Boys Club member. Died in 1306 from hitting massive bong rips.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RUDOLFJR_2c6b25d12f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUDOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUDOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

