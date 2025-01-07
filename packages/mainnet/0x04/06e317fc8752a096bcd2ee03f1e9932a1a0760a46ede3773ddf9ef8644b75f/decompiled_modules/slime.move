module 0x406e317fc8752a096bcd2ee03f1e9932a1a0760a46ede3773ddf9ef8644b75f::slime {
    struct SLIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIME>(arg0, 6, b"SLIME", b"SLIME", b"SLIMEST meme on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media1.tenor.com/m/62VNwTcR7r8AAAAC/slime-purple-slime.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLIME>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

