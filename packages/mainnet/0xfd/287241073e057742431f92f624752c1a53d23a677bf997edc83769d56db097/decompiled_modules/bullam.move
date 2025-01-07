module 0xfd287241073e057742431f92f624752c1a53d23a677bf997edc83769d56db097::bullam {
    struct BULLAM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BULLAM>, arg1: 0x2::coin::Coin<BULLAM>) {
        0x2::coin::burn<BULLAM>(arg0, arg1);
    }

    fun init(arg0: BULLAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLAM>(arg0, 9, b"bullam", b"bullam", b"Introducing BullAm, the meme token that represents the strength and resilience of the American Bulldog breed and symbolizes the robustness of blockchain technology, artificial intelligence, and data analysis. Named after the beloved American Bulldog, BullAm is more than just a meme token. It is a beacon for awareness and understanding of the future of technology.  BullAm is not just about generating laughs or market fluctuations; it's about knowledge and awareness. Much like the American Bulldog, known for its courage, good nature, and strength, BullAm showcases the power of the blockchain, the intelligence of AI, and the insight of data analysis.  Inspired by the triptych of blockchain, AI, and data analysis, BullAm is devoted to promoting education and awareness around these crucial technological areas. By participating in the BullAm community, holders are not only investing in a meme token with potential market benefits, but they're also becoming part of a movement that values knowledge and innovation in the tech world.  The ultimate goal of BullAm is to become a symbol of the technological revolution, fostering a community that understands and appreciates the power of blockchain, AI, and data analysis. Hold BullAm, hold the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/zBa7UjQ.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLAM>>(v1);
        0x2::coin::mint_and_transfer<BULLAM>(&mut v2, 210000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLAM>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BULLAM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BULLAM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

