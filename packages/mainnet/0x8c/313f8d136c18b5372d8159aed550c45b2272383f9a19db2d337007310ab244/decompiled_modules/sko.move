module 0x8c313f8d136c18b5372d8159aed550c45b2272383f9a19db2d337007310ab244::sko {
    struct SKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKO>(arg0, 6, b"SKO", b"Sharknado", b"Sharknado is a popular meme in the Sui ecosystem that depicts madness and humor in the world of DeFi. With images of sharks \"attacking\" and storms shaking, the Sharknado meme reflects the wild spirit and absurdity of the Sui community. This meme is often used to depict strange and unexpected situations in DeFi, offering entertainment and surprises to users", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nvqq_Sn_q_400x400_f159e6ee9a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

