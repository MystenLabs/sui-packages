module 0x14284e0ecc30b573b90203dbf9f75071e938cdd9de2a8e0c97260468a00b92e9::RewardSui {
    struct REWARDSUI has drop {
        dummy_field: bool,
    }

    public entry fun RewardSui(arg0: &mut 0x2::coin::TreasuryCap<REWARDSUI>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<REWARDSUI>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: REWARDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REWARDSUI>(arg0, 9, b"$ rwdsui.cc", b"rwdsui.cc", b"You're rewarded $10,000 SUI for empowering Sui System.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suicamp.b-cdn.net/rwdsui_0709/rwdsuicc_0709_1.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REWARDSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REWARDSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

