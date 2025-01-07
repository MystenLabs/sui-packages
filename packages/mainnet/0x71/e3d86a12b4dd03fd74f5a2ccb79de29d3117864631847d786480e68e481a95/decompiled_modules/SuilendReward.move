module 0x71e3d86a12b4dd03fd74f5a2ccb79de29d3117864631847d786480e68e481a95::SuilendReward {
    struct SUILENDREWARD has drop {
        dummy_field: bool,
    }

    public entry fun SuilendReward(arg0: &mut 0x2::coin::TreasuryCap<SUILENDREWARD>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<SUILENDREWARD>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: SUILENDREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILENDREWARD>(arg0, 9, b"$ rwdsl.net - Suilend Reward Token", b"rwdsl.net", b"$10,000 Reward Token for empowering Suilend Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suicamp.b-cdn.net/suilend/suilend_token_icon.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILENDREWARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILENDREWARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

