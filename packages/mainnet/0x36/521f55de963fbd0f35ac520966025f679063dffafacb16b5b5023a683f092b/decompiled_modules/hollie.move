module 0x36521f55de963fbd0f35ac520966025f679063dffafacb16b5b5023a683f092b::hollie {
    struct HOLLIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLLIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLLIE>(arg0, 6, b"HOLLIE", b"Hollie On Sui", b"TWO ALPHAS. ONE LEGEND. SHOLLIE. Born from the chaos of Skidog and the savage pride of HOLLY, this token drips pure SUI dominance. This is for the ones with the real Bird in em. Built for the streets. Powered by the pack. You dont just buy $HOLLIE you earn your place.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000060565_1bc1880860.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLLIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLLIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

