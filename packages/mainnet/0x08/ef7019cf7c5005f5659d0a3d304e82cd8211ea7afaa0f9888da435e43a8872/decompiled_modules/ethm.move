module 0x8ef7019cf7c5005f5659d0a3d304e82cd8211ea7afaa0f9888da435e43a8872::ethm {
    struct ETHM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETHM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETHM>(arg0, 6, b"ETHm", b"ETHmeme", b"ETH Meme (ETH M) is a meme token built on the Sui network as a tribute to Ethereum (ETH). Combining community spirit and meme culture, ETH M is designed to provide entertainment and value to crypto enthusiasts. With innovative features and active community support, ETH M aims to create a fun and creative ecosystem while celebrating the strength and influence of Ethereum in the blockchain world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000087228_02da041b37.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETHM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETHM>>(v1);
    }

    // decompiled from Move bytecode v6
}

