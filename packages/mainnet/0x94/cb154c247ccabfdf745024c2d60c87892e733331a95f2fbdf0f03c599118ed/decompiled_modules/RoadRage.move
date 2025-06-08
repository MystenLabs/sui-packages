module 0x94cb154c247ccabfdf745024c2d60c87892e733331a95f2fbdf0f03c599118ed::RoadRage {
    struct ROADRAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROADRAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROADRAGE>(arg0, 9, b"RDRG", b"RoadRage", b"move bitch, get out of my way. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/ed3a6ab9-451a-45e5-a1a7-6dfa2113960e.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROADRAGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROADRAGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

