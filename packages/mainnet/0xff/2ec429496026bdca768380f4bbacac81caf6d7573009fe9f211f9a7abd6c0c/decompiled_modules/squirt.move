module 0xff2ec429496026bdca768380f4bbacac81caf6d7573009fe9f211f9a7abd6c0c::squirt {
    struct SQUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRT>(arg0, 9, b"SQUIRT", b"SQUIRTLE", b" Dive into the fun with Squirtle on Sui . the community-driven Pokemon coin on the Sui blockchain! Join the Squirtle Squad for a splash of memes, challenges.Ride the suinami and let Squirtle lead you to the oasis and a sea of possibilities .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/a/jFPm7hW")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SQUIRT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

