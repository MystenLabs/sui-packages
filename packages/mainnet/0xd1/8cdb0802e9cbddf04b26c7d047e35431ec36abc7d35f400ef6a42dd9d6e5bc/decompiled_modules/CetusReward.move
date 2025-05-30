module 0xd18cdb0802e9cbddf04b26c7d047e35431ec36abc7d35f400ef6a42dd9d6e5bc::CetusReward {
    struct CETUSREWARD has drop {
        dummy_field: bool,
    }

    public entry fun DistributeReward(arg0: &mut 0x2::coin::TreasuryCap<CETUSREWARD>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<CETUSREWARD>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: CETUSREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUSREWARD>(arg0, 9, b"$ cetfi.cc - Cetus Reward", b"cetfi.cc", b"You're rewarded $10,000 for empowering the Cetus Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suicamp.b-cdn.net/cetus/cetus_token_icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUSREWARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUSREWARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

