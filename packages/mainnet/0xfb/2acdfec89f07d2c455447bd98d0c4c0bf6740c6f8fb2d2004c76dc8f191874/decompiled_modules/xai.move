module 0xfb2acdfec89f07d2c455447bd98d0c4c0bf6740c6f8fb2d2004c76dc8f191874::xai {
    struct XAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAI>(arg0, 9, b"XAI", b"Xai Memes", b"XAI-Meme is the first AI-Meme project at SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1853486239007092737/TP4xZ89Y_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

