module 0xb9ea339e1eed9792d3276b6e37374f28537ee0d6718f4edac3cf11ebd09edda9::taxi {
    struct TAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAXI>(arg0, 6, b"Taxi", b"RoboTaxi", b"Robotaxi (TAXI) is an SUI-based blockchain project created to honor Elon Musk's ambitious vision of a fully autonomous future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_25_07_06_03_6d6d76e9c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

