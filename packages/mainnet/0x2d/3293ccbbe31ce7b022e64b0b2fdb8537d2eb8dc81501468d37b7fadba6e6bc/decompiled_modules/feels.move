module 0x2d3293ccbbe31ce7b022e64b0b2fdb8537d2eb8dc81501468d37b7fadba6e6bc::feels {
    struct FEELS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEELS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEELS>(arg0, 6, b"FEELS", b"FEELS MEME COIN", b"Don't Follow Me ! I feel good but not really good. Launched on SUI. LFG !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_17_22_56_23_51543e5587.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEELS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEELS>>(v1);
    }

    // decompiled from Move bytecode v6
}

