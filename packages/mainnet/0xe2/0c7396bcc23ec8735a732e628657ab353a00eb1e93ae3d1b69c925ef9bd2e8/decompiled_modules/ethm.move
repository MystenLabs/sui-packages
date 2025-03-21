module 0xe20c7396bcc23ec8735a732e628657ab353a00eb1e93ae3d1b69c925ef9bd2e8::ethm {
    struct ETHM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETHM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETHM>(arg0, 6, b"ETHm", b"Ethereum meme", b"ETH Meme (ETH M) is a meme token built on the Sui network as a tribute to Ethereum (ETH). Combining community spirit and meme culture, ETH M is designed to provide entertainment and value to crypto enthusiasts. With innovative features and active community support, ETH M aims to create a fun and creative ecosystem while celebrating the strength and influence of Ethereum in the blockchain world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000087228_357ebf708a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETHM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETHM>>(v1);
    }

    // decompiled from Move bytecode v6
}

