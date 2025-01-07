module 0xbc47350bd39136a1b73d1ab7f0447d9617d6ca5a0c6ad1ceab1b037e8981043a::boris {
    struct BORIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORIS>(arg0, 6, b"BORIS", b"BORIS on SUI", b"$BORIS is all about a cute little rabbit rocking a sleek suit and shades, bringing style and fun to the Sui. Hop into the world of $BORIS and let this fashionable bunny lead you to cool gains and good vibes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/boris_7669043238.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

