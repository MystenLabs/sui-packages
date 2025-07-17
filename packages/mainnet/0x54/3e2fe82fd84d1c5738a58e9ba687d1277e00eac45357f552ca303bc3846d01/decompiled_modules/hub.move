module 0x543e2fe82fd84d1c5738a58e9ba687d1277e00eac45357f552ca303bc3846d01::hub {
    struct HUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUB>(arg0, 6, b"HUB", b"HubCoin", b"HUB Coin is your irresistible invitation to indulge in pure digital seduction", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibo54dtkgrhpu7ouq6ozkyiikky5qy6soobfxtsqegauvisd5x4di")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HUB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

