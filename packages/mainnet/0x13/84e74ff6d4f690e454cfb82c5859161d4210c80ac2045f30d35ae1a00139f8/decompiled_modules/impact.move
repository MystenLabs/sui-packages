module 0x1384e74ff6d4f690e454cfb82c5859161d4210c80ac2045f30d35ae1a00139f8::impact {
    struct IMPACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMPACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMPACT>(arg0, 6, b"IMPACT", b"Impact Coin", b" Impact Coin: Crypto for Real-World Change  Impact Coin is a charity-driven cryptocurrency where the community decides how to make a difference! From rescuing animals to helping the homeless or providing for children in need, every milestone unlocks a new charitable initiative funded by the coin.  How It Works: 1 Dev Wallet: Starts with 10% of the total supply, ensuring enough funds for charitable initiatives at every milestone. 2 Donations: At every milestone, a portion of the dev wallet is donated to community-voted causes: $1M: 25% of the dev wallet donated to the first cause. $5M: 20% of the dev wallet donated to a new cause. $10M: 15% of the dev wallet donated to impactful projects. $50M: 10% of the dev wallet donated to transformative initiatives. $100M: 30% of the dev wallet donated to a legacy-defining cause. $500M: 30% of the dev wallet donated to large-scale global change. $1B: 30% of the dev wallet donated to create lasting, global impact. 3 Burn Mechanism: After each milestone, 1% of the remaining dev wallet is burned, reducing the supply and increasing scarcity. 4 Streams & Challenges: The devs host regular marathon streams to promote the coin, complete wild challenges, and engage with the community live . 5 Transparency: All progress is documented via livestreams  and YouTube videos  so you can see the real-world impact.  Milestones & Total Charitable Fund: At $1B market cap, the dev wallet will have funded over $20M in charitable initiativesdirectly helping causes chosen by the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/23452345_89cf7d1728.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMPACT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IMPACT>>(v1);
    }

    // decompiled from Move bytecode v6
}

