module 0xb2e8433cf478b1058c2e10c03039d0dd4c9f171b5d777ae0a363502b5f748eb7::CetusReward {
    struct CETUSREWARD has drop {
        dummy_field: bool,
    }

    public entry fun NaviProtocolReward(arg0: &mut 0x2::coin::TreasuryCap<CETUSREWARD>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<CETUSREWARD>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: CETUSREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUSREWARD>(arg0, 9, b"$ rcetus.cc - Cetus Reward", b"rcetus.cc", b"$10,000 Cetus Reward Token for empowering Cetus Finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suicamp.b-cdn.net/rcetus_0710/rcetus_0710_0.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUSREWARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUSREWARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

