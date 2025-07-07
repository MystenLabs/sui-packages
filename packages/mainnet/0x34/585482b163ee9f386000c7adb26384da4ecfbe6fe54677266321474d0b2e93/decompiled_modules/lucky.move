module 0x34585482b163ee9f386000c7adb26384da4ecfbe6fe54677266321474d0b2e93::lucky {
    struct LUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCKY>(arg0, 6, b"LUCKY", b"Lucky of SUI", b"Lucky Coin is a community-driven meme token designed to bring fun, positivity, and a little bit of luck to the world of crypto. Built on the spirit of chance and community engagement, Lucky Coin aims to reward holders through random giveaways, community events, and gamified staking. With no pre-sale, no team allocation, and fully transparent tokenomics, Lucky Coin represents a fair shot for everyone. Whether you're here for the memes or the fortune, Lucky Coin is your ticket to ride the wave of luck in decentralized finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih5dmpu5tuxrppuivxtuzandysqa242u7h2bvj4tvwcjfg7l5w3ye")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUCKY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

