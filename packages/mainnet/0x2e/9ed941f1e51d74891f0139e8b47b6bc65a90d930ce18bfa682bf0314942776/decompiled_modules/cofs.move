module 0x2e9ed941f1e51d74891f0139e8b47b6bc65a90d930ce18bfa682bf0314942776::cofs {
    struct COFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COFS>(arg0, 6, b"COFS", b"Cat On Fire SUI", b"$COF is the newest meme token created on the Base network that wants to make its mark on the market. His first goal is to be listed on Uniswap at the end", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fire_ed30fa720f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

