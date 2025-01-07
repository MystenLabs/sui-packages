module 0x6f19c139f41e2e37214d22b3ea423c7b340f5c8bc409ea1e1d1c2f6096eadea4::cheems {
    struct CHEEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEEMS>(arg0, 9, b"CHEEMS", b"Sui Cheems", b"Inspired by the iconic internet meme, Cheems the dog, this project aims to capture the nostalgic spirit and community-driven ethos that characterized the early days of cryptocurrencies. Telegram: https://t.me/suicheems Website: https://suicheems.xyz/ X: https://x.com/suicheemssui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/QmS33wnYcgyYHMq1Y9FK4ypbaC7ZUG9E8H3TRftfMyzqje")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHEEMS>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEEMS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

