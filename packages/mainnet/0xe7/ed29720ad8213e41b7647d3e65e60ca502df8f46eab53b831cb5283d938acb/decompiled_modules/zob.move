module 0xe7ed29720ad8213e41b7647d3e65e60ca502df8f46eab53b831cb5283d938acb::zob {
    struct ZOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOB>(arg0, 6, b"ZOB", b"Zob on Sui", b"HOORAYYY!!! $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB $ZOB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049553_b89946b329.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

