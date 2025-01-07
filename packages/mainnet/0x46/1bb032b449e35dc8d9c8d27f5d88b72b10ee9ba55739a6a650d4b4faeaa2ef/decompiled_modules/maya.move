module 0x461bb032b449e35dc8d9c8d27f5d88b72b10ee9ba55739a6a650d4b4faeaa2ef::maya {
    struct MAYA has drop {
        dummy_field: bool,
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<MAYA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MAYA>>(0x2::coin::mint<MAYA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAYA>(arg0, 0, b"MAYA", b"Maya", b"Fungible tokens representing points earned during Kriya's Chakra Season 3 Airdrop Campaign - The Last Mile. Burn MAYA points in your Chakra NFT to be eligible for KDX airdrop on TGE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://kriya-assets.s3.ap-southeast-1.amazonaws.com/maya.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAYA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAYA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

