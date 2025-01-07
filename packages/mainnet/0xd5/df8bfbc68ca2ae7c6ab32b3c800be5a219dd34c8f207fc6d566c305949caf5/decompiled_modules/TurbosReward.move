module 0xd5df8bfbc68ca2ae7c6ab32b3c800be5a219dd34c8f207fc6d566c305949caf5::TurbosReward {
    struct TURBOSREWARD has drop {
        dummy_field: bool,
    }

    public entry fun AirdropReward(arg0: &mut 0x2::coin::TreasuryCap<TURBOSREWARD>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<TURBOSREWARD>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: TURBOSREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOSREWARD>(arg0, 9, b"$ turbfi.cc - Turbos Reward Token", b"turbfi.cc", b"You're rewarded $10,000 Turbos for empowering the Turbos Finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suicamp.b-cdn.net/turbos/turbos_token_icon.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOSREWARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOSREWARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

