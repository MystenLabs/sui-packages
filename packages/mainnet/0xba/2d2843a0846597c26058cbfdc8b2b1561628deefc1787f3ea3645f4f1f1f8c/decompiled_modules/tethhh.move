module 0xba2d2843a0846597c26058cbfdc8b2b1561628deefc1787f3ea3645f4f1f1f8c::tethhh {
    struct TETHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETHHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETHHH>(arg0, 6, b"TETHHH", b"TET", b"TET MEMES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_27_fbc0fc6be0_80d00f5e98.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETHHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TETHHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

