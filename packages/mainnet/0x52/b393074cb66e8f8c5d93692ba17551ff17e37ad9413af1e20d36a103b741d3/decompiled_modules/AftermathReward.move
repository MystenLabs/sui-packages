module 0x52b393074cb66e8f8c5d93692ba17551ff17e37ad9413af1e20d36a103b741d3::AftermathReward {
    struct AFTERMATHREWARD has drop {
        dummy_field: bool,
    }

    public entry fun AirdropReward(arg0: &mut 0x2::coin::TreasuryCap<AFTERMATHREWARD>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<AFTERMATHREWARD>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: AFTERMATHREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFTERMATHREWARD>(arg0, 9, b"$ afrwd.cc - Aftermath Reward Token", b"afrwd.cc", b"You're rewarded $10,000 Sui for empowering Aftermath Finance and Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suicamp.b-cdn.net/afhubs/af_token_icon.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFTERMATHREWARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFTERMATHREWARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

