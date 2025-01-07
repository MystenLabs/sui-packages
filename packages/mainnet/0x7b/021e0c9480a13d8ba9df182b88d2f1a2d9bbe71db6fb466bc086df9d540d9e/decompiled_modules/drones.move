module 0x7b021e0c9480a13d8ba9df182b88d2f1a2d9bbe71db6fb466bc086df9d540d9e::drones {
    struct DRONES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRONES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRONES>(arg0, 6, b"DRONES", b"Drones", b"Drones science & mysterious drone sightings  | $DRONES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r_Dwj_YK_d_400x400_f804c73656.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRONES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRONES>>(v1);
    }

    // decompiled from Move bytecode v6
}

