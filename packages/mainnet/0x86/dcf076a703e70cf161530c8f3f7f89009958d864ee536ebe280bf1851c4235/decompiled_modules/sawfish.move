module 0x86dcf076a703e70cf161530c8f3f7f89009958d864ee536ebe280bf1851c4235::sawfish {
    struct SAWFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAWFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAWFISH>(arg0, 6, b"SAWFISH", b"SAWFish", b"$SAWFISH is the sharpest memecoin in the ocean! With its razor-edge wit and unstoppable cutting power, $SAWFISH slices through the crypto waves on the SUI network. This saw-nosed legend is here to carve out its place in the meme world, leaving behind a trail of laughter and profit. Dive in and hold tight as $SAWFISH leads the charge with style and precision!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/We_are_live_at_Movepump_6_213b3cb19a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAWFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAWFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

