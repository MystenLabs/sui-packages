module 0x1db970d2a9b5ae5a57d62fdc9932c5d481aad193c4f1bf15d399de4afb7fe44b::iris {
    struct IRIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRIS>(arg0, 9, b"IRIS", b"Iris", b"IRIS IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/029/368/large/alex-gray-3d-tbrender-camera-28-fullquality.jpg?1726493417")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IRIS>(&mut v2, 50000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRIS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

