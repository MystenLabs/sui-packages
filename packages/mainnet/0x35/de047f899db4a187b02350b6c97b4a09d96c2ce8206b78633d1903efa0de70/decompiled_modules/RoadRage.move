module 0x35de047f899db4a187b02350b6c97b4a09d96c2ce8206b78633d1903efa0de70::RoadRage {
    struct ROADRAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROADRAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROADRAGE>(arg0, 9, b"RDRG", b"RoadRage", b"move bitch, get out of my way. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/90f0552e-f54c-47de-a727-7def218be9e6.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROADRAGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROADRAGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

