module 0xb2f132b358cdd9f1e07e26bff799a8f7a60ddf08e354722f2f2fd893dd02b7bb::pillz {
    struct PILLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PILLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PILLZ>(arg0, 6, b"PILLZ", b"Pillz", b"From the Creator of Ether Pillz: Sevem New Pillz are created and they Emerge on 7chains . Which Chain Will Claim the Meme Coin Throne?Ether Pillz was just the beginninga bold entry into the meme coin universe. Now, the Pillz are back with seven new tokens, each representing a different blockchain: Ethereum, Avax, Base, Tron, Solana, BSC and now SUI. These Pillz are more than just tokens; they are a testament to the diverse power of different chains, united in the quest to crown the ultimate meme coin king.Each Pillz token harnesses the unique strengths of its respective network. Adding Sui to our website this week ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_30624d7e91.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PILLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PILLZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

