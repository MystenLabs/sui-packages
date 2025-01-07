module 0xec2a3fa8bb86870648766a42e3c9ca3634f4f95572546a804da2dce5550504d7::bd {
    struct BD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BD>(arg0, 6, b"BD", b"MOO DENG ON SUI", b"**MOO DENG** on Sui is a **meme coin** focused on community engagement and fun. Built on the Sui blockchain, it leverages fast transactions and low fees. While primarily for entertainment, MOO DENG may expand into features like staking or NFTs based on community trends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_23_at_2_40_10a_pm_bd560fbfb6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BD>>(v1);
    }

    // decompiled from Move bytecode v6
}

