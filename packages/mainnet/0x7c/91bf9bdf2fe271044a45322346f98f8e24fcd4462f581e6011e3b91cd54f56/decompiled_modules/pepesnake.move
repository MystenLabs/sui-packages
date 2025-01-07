module 0x7c91bf9bdf2fe271044a45322346f98f8e24fcd4462f581e6011e3b91cd54f56::pepesnake {
    struct PEPESNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPESNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESNAKE>(arg0, 6, b"PepeSnake", b"PepeSnake on sui", b"$PEPESNAKE IS A COMMUNITY-DRIVEN MEME COIN INSPIRED BY THE YEAR 2025 AND ITS SYMBOLIC ANIMAL, THE SNAKE. WE BELIEVE IN THE POWER OF DECENTRALIZED FINANCE AND THE POTENTIAL FOR MEME COINS TO DISRUPT THE TRADITIONAL FINANCIAL SYSTEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_O_Mqq_Ogp_400x400_6ec04c9119.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESNAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPESNAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

