module 0xd17dd2b3d6c07a26a27c2a60b44630ca63f448cde9df46d2a3ee7d0f93a88354::slove {
    struct SLOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOVE>(arg0, 9, b"SLOVE", b"SuiLove", b"Show some love for SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/c/c8/Love_Heart_symbol.svg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLOVE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOVE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

