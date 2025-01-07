module 0xc7583d76b677c9acbe30635b819e4709cdd0435d46326c4afeffccca3c065398::robotaxi {
    struct ROBOTAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOTAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOTAXI>(arg0, 6, b"ROBOTAXI", b"Robotaxi on Sui", b"Robotaxi (TAXI) is an Sui-based blockchain project created to honor Elon Musk's ambitious vision of a fully autonomous future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6021587721891464726_48d853cfee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOTAXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOTAXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

