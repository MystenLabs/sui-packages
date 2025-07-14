module 0x48bc0de64c31f66edfbe7fff528150e4ca7e7bcecec62b5a55f69a4b38db2663::winter {
    struct WINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINTER>(arg0, 6, b"Winter", b"Winter AI", b"Winter Ai is the ultimate token of the Sui blockchain, inspired by the relentless Winter Ai Agent, its a symbol of agility, precision, and dominance in the crypto realm. With a fierce community and a mission to lead the charge in DeFi, Winter Ai is not just a token its a revolution. Join the movement, hold tight, and unleash the power to dominate the market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig74bdeeul667uokxyp6ss3pkkfts7iewznoyhwkeuc4q24v2wcru")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WINTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

