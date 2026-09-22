module 0x222c5dd1f32b475b563232bc8b160f52c15a3d5a8f8fa1f9b311b743ee670358::hedo {
    struct HEDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEDO>(arg0, 9, b"HEDO", b"Hedgehog Ops", b"Hedgehog Ops is a meme-native meme token channeling shiba spirit for Discord quests, tipping, and quick raids.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmT8ZSELDCcitFnWVGxt1PSJiuQgqCLaQLSFaKCUb62gue")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<HEDO>>(0x2::coin::mint<HEDO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEDO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEDO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

