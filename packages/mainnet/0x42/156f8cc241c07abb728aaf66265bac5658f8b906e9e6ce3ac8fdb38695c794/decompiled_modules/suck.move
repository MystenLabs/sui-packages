module 0x42156f8cc241c07abb728aaf66265bac5658f8b906e9e6ce3ac8fdb38695c794::suck {
    struct SUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCK>(arg0, 6, b"SUCK", b"Suck the Duck", b"suckduck.xyz . Look out, world, Suck's coming through, and he's not ducking around anymore! He's a degenerate duck on Sui, ready to take down any other meme in his path!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_15_103000_77a8a24541.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

