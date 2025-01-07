module 0x33799f536fa9eb71dd23cac522f4fb1689be726351f2ede962618c5285ac77c2::terminus {
    struct TERMINUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMINUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMINUS>(arg0, 6, b"TERMINUS", b"First City in Mars", b"There is a prospect greater than the sea, and it is the sky; there is a prospect greater than the sky, and it is the human soul.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mars_30ffe9fb4b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMINUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TERMINUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

