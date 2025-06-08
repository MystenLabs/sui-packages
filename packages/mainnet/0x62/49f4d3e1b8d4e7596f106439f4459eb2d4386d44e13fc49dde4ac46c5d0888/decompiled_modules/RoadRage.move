module 0x6249f4d3e1b8d4e7596f106439f4459eb2d4386d44e13fc49dde4ac46c5d0888::RoadRage {
    struct ROADRAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROADRAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROADRAGE>(arg0, 9, b"RDRG", b"RoadRage", b"move bitch, get out of my way. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/cf06035a-3db5-4a6c-b722-e5a037760cea.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROADRAGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROADRAGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

