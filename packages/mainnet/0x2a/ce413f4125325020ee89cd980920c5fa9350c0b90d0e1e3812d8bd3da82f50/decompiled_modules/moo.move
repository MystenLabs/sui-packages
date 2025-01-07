module 0x2ace413f4125325020ee89cd980920c5fa9350c0b90d0e1e3812d8bd3da82f50::moo {
    struct MOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOO>(arg0, 6, b"MOO", b"Moo On Sui", b"Get ready for Moo, the most fun cow-themed memecoin on the Sui Network! Its a lighthearted, community-driven token thats all about bringing some humor to the crypto world. Whether you're here for the laughs or to join a growing movement, Moo is your chance to be part of something unique. Its a playful, pasture-inspired token with a focus on community and funperfect for anyone looking to get involved in the next big thing in memecoins. Ready to join the herd? Lets make some noise with Moo! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/oggy_favicon_20240930_081328_0000_8236d312a1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

