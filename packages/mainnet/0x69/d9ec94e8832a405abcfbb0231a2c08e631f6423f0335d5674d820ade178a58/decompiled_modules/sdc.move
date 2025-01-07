module 0x69d9ec94e8832a405abcfbb0231a2c08e631f6423f0335d5674d820ade178a58::sdc {
    struct SDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDC>(arg0, 6, b"SDC", b"Suiduckz Coin", b"Quack Quack Quack Quack Quack Quack! Introducing Suiduckz Coin ($SDC), the official meme token of the Suiduckz project on the Sui network! Based on the recent vote, SuiDuckz NFT holders and SuiDuckz Eggs NFT holders have agreed to create this meme token. $SDC aims to engage the community while driving the adoption of WEB3. Join us as we build a decentralized future, one quack at a time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Duckz_Coin_f3ef8c51ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

