module 0x26ef969570a7e80d99fb10f361f2d23e57232f178966e7c34bb97fd4046cff6b::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 6, b"MAGA", b"HarryPotterTrumpPnut10inu", b"HarryPotterTrumpPnut10inu Coin on Solana combines fantasy with satire to celebrate Trump's presidential win. Featuring Trump with a Bitcoin wallet and magical characters in a retro setting, it invites users to explore crypto with humor. This unique token blends pop culture and decentralized finance, drawing in collectors and fans alike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_06_09_34_30_cecdf11e62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

