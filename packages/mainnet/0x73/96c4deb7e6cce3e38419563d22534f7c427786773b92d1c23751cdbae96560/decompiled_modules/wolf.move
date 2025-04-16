module 0x7396c4deb7e6cce3e38419563d22534f7c427786773b92d1c23751cdbae96560::wolf {
    struct WOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLF>(arg0, 6, b"WOLF", b"Sui Wolf Pack", b"Sui Wolf Pack is a fierce, community-driven meme coin built for those who run with the pack. Inspired by the strength, loyalty, and untamed spirit of wolves, $WOLF unites holders in a decentralized hunt for financial freedom. With a deflationary token model, howling community events, and plans for NFT integration, Wolf Pack is more than a coin, it's a movement. Join the pack, stake your claim, and moon with the alpha.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreignxc3u5ahjqqfhtsrw4y52wwrbm2rmxqyhit6fibuev45qrnmb7m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOLF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

