module 0xf21bfb29df933d467f45d2664714acde1da2c2febbeef482ce10cd2916b11723::sonic {
    struct SONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONIC>(arg0, 6, b"SONIC", b"SONIC SUI", b"Gotta go fast with $SONIC on Sui! This coin speeds through the blockchain like the blue hedgehog himself. No one can catch this one.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sonic_85d40414de_9ff48d95d7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

