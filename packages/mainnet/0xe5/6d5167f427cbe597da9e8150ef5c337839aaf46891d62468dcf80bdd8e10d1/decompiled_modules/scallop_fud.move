module 0xe56d5167f427cbe597da9e8150ef5c337839aaf46891d62468dcf80bdd8e10d1::scallop_fud {
    struct SCALLOP_FUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_FUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_FUD>(arg0, 5, b"sFUD", b"sFUD", b"Scallop interest-bearing token for FUD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://enx3zetzw42z2gpckvye66ljal2vfu63rb2qc5arvq7wof3xdbhq.arweave.net/I2-8knm3NZ0Z4lVwT3lpAvVS09uIdQF0Eaw_Zxd3GE8")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_FUD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_FUD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

