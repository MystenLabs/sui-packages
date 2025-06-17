module 0x288dccadf2479f48c380a046ebee39695dc1b4f4594f29108168dc9b3424a81c::fartcat {
    struct FARTCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTCAT>(arg0, 6, b"FARTCAT", b"Sui Fartcat", b"I run on fart, not fiat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidjamzhhj5egk6fieufwbfyic5emaek36hmselt2mdjrdn7oine4y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FARTCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

