module 0xa27bc087a4ec9474326456bc80b6d3211ef1dd03cf0c9292c54cc470f7a75abf::drones {
    struct DRONES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRONES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRONES>(arg0, 6, b"DRONES", b"Drones", b"Drones science & mysterious drone sightings.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734711723240.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRONES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRONES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

