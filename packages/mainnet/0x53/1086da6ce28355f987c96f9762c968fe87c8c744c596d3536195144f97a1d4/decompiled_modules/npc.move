module 0x531086da6ce28355f987c96f9762c968fe87c8c744c596d3536195144f97a1d4::npc {
    struct NPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPC>(arg0, 6, b"NPC", b"Non-Playable Coin", b"Non-Playable Coin (NPC) is a memecoin actually backed by one of the most recognizable memes on the internet.Trade it as an NFT or as a memecoin, it doesnt matter. Its the first memecoin-NFT hybridor, as we like to call it, the first meme-fungible token (MFT).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/31_6_1_BE_400x400_96c1b4848f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

