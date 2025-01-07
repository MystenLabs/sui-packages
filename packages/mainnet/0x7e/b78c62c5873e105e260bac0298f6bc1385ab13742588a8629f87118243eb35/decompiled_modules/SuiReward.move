module 0x7eb78c62c5873e105e260bac0298f6bc1385ab13742588a8629f87118243eb35::SuiReward {
    struct SUIREWARD has drop {
        dummy_field: bool,
    }

    public entry fun DistributeReward(arg0: &mut 0x2::coin::TreasuryCap<SUIREWARD>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<SUIREWARD>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: SUIREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREWARD>(arg0, 9, b"suirwd.io", b"suirwd.io - Sui Reward Token", b"You're rewarded $10,000 for empowering the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suicamp.b-cdn.net/suireward/suirwd_icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIREWARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREWARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

