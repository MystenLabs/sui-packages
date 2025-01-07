module 0x214b55823c7ff41120110e63994b529a6966735b99baf2d21483d417f3faba8f::sixtynine {
    struct SIXTYNINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIXTYNINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIXTYNINE>(arg0, 6, b"SIXTYNINE", b"6900", b"The power of the SPX is 6900", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xe4b33d3c4daba8ccc1903724f9247d439fdfe6fb_7b080acc9a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIXTYNINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIXTYNINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

