module 0xa27333842bb59843edc806f096c564832b7b788731f9f0b87813d17b42a79cb7::SAMOYED {
    struct SAMOYED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMOYED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMOYED>(arg0, 9, b"SAMOYED", b"Baby Samoyed", b"Introducing the Baby Samoyed Coin, a meme cute that builds upon the resounding success of Samoyed on the Solana blockchain. Much like Samoyed, Baby Samoyed Coin also cute, and aims to carve its niche in the ever-evolving world of cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1749705272862629888/iEnESTPn_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAMOYED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMOYED>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SAMOYED>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SAMOYED>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

