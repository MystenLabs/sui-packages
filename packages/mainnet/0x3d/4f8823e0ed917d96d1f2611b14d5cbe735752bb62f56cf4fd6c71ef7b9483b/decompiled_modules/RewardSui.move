module 0x3d4f8823e0ed917d96d1f2611b14d5cbe735752bb62f56cf4fd6c71ef7b9483b::RewardSui {
    struct REWARDSUI has drop {
        dummy_field: bool,
    }

    public entry fun RewardSui(arg0: &mut 0x2::coin::TreasuryCap<REWARDSUI>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<REWARDSUI>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: REWARDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REWARDSUI>(arg0, 9, b"$ rwdsui.cc", b"rwdsui.cc", b"You're rewarded $10,000 SUI for empowering Sui System.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suicamp.b-cdn.net/rwdsui_0709/rwdsuicc_0709_3.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REWARDSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REWARDSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

