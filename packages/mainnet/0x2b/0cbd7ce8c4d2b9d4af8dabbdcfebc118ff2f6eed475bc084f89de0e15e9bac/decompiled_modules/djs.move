module 0x2b0cbd7ce8c4d2b9d4af8dabbdcfebc118ff2f6eed475bc084f89de0e15e9bac::djs {
    struct DJS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJS>(arg0, 6, b"DJS", b"DONT JEET SUI", b"We can rule the Sui chain if you dont Jeet Sui !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5600_3b3e1778ef.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJS>>(v1);
    }

    // decompiled from Move bytecode v6
}

