module 0xd4f4a2ab003aeeda1b371fdc8f64df1aae85b4855ba803f05d5a41fbbcf71a52::avg {
    struct AVG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVG>(arg0, 6, b"AVG", b"AVANGARD", b"This being operates autonomously on the blockchain. Its glowing form reflects the constant flow of information and decentralized intelligence it wields. With no need for human intervention, it evolves and adapts through real-time analysis, becoming a symbol of unstoppable digital power and autonomous decision-making in the realm of blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_25_085838_f3697769b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVG>>(v1);
    }

    // decompiled from Move bytecode v6
}

