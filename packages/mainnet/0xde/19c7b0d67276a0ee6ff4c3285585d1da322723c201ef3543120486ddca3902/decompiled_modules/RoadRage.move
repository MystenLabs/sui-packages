module 0xde19c7b0d67276a0ee6ff4c3285585d1da322723c201ef3543120486ddca3902::RoadRage {
    struct ROADRAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROADRAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROADRAGE>(arg0, 9, b"RDRG", b"RoadRage", b"move bitch get out the way!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/03df8514-a2e6-4793-aad0-0dbcfeb393c1.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROADRAGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROADRAGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

