module 0x7a510e33358e90c8e98730bb7eae9ce2b3272b1086aa5e294042eb52da3fa5d5::chaotic {
    struct CHAOTIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAOTIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAOTIC>(arg0, 6, b"Chaotic", b"Chaotic Sonic", b"Chaotix Sonic is a revolutionary cryptocurrency inspired by the dynamic world of Sonic the Hedgehog. Built for speed and efficiency, it embodies the energy, adaptability, and teamwork of the iconic Chaotix team. Whether you're zipping through high-speed transactions or navigating the unpredictable twists of the crypto market, Chaotix Sonic keeps you ahead of the curve.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7463_38b1cf840d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAOTIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAOTIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

