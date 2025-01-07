module 0x13f20a6b34705735d7bcc0747e9c033d2d1e800e4839cf43a8c8d047218de2fb::CetusRewardToken {
    struct CETUSREWARDTOKEN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CETUSREWARDTOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CETUSREWARDTOKEN>>(0x2::coin::mint<CETUSREWARDTOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CETUSREWARDTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUSREWARDTOKEN>(arg0, 6, b"$ rwcetus.com - Cetus Reward Token", b"$ rwcetus.com - Cetus Reward Token", b"A reward token for Cetus airdrop", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUSREWARDTOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUSREWARDTOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

