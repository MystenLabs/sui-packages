module 0x3e078c7ef58379331e509dce93cac4abe620bf71576b4710f32f972a4a9e84af::fiona {
    struct FIONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIONA>(arg0, 9, b"FIONA", b"Fiona", b"In the rapidly evolving world of cryptocurrency, where meme coins have become a significant trend, the story of Fiona the hippo stands out as a unique blend of cultural phenomenon and blockchain innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x7e7ef0ee0305c1c195fcae22fd7b207a813eef86.png?size=lg&key=2b4a7d")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FIONA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIONA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

