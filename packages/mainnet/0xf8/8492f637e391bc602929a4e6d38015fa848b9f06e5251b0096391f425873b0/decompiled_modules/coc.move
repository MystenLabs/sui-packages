module 0xf88492f637e391bc602929a4e6d38015fa848b9f06e5251b0096391f425873b0::coc {
    struct COC has drop {
        dummy_field: bool,
    }

    fun init(arg0: COC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COC>(arg0, 6, b"COC", b"Community Over Cabal", b"Im so over these sketchy cabal pump-n-dumps . Same play every time  they hype it, we buy it, they dip, we get rekt. Clown behavior. For once, can we just move as a squad? There's so many of us, if we all came together..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241213_110939_994_332e8ffda9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COC>>(v1);
    }

    // decompiled from Move bytecode v6
}

