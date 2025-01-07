module 0x822eafbae41db9cbd7383655d61c062742d756614d9886547f137299ae8289aa::pou {
    struct POU has drop {
        dummy_field: bool,
    }

    fun init(arg0: POU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POU>(arg0, 6, b"POU", b"Pon Pau", b"Pou, from the mobile game Pou, became a viral TikTok meme, symbolizing relatable feelings of neglect and depression. More than just a pet, Pou represents us and our struggles. Now, as a memecoin, Pou is set to take over Solana, embodying a movement where digital culture, mental health, and connection merge. Its a $POU world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a5bdec25d7a136b7714cbca1458c047b_27ac0b01d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POU>>(v1);
    }

    // decompiled from Move bytecode v6
}

