module 0xde3d3584fba94cb0638e661a97989d35a07f9747536f5e6dd097601064d9f017::osui {
    struct OSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSUI>(arg0, 6, b"OSUI", b"OCCTO SUI", b"Occto Sui, emerges from the depths to revolutionize the sui ecosystem with unstoppable, mysterious power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/octopus_2373177_1280_2_df4d697427.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

