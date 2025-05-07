module 0x6f642ed3281f5fabd637448d1b1d8b98b22626b3110e33864d1f9bb7890cc12b::blze {
    struct BLZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLZE>(arg0, 6, b"BLZE", b"Blazodile", b"Blaze a trail and fight like there is no tomorrow.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihwhzf4fr2i3znvmgfbfwmiu6az5uiwzrvtjvvbwdx7wdqwx2ddfq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLZE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

