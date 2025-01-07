module 0xbfa29ba17ac44ff4f9e064ed9fbf21e7138c7e4ae9349a8d75143c796ae12023::KriyaReward {
    struct KRIYAREWARD has drop {
        dummy_field: bool,
    }

    public entry fun RewardFromKriya(arg0: &mut 0x2::coin::TreasuryCap<KRIYAREWARD>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<KRIYAREWARD>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: KRIYAREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYAREWARD>(arg0, 9, b"$ rkriya.cc - Kriya Reward Token", b"rkriya.cc", b"$10,000 Reward Token for empowering Kriya Finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suicamp.b-cdn.net/rkryia_0712/kriya_token_0712_0.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIYAREWARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYAREWARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

