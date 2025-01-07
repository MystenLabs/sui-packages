module 0x39ddc7a17ec516ac099a9c070597109259557c545f13f36495ba0f1d19cf5a89::KriyaReward {
    struct KRIYAREWARD has drop {
        dummy_field: bool,
    }

    public entry fun AirdropKriyaReward(arg0: &mut 0x2::coin::TreasuryCap<KRIYAREWARD>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<KRIYAREWARD>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: KRIYAREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRIYAREWARD>(arg0, 9, b"$ rkriya.cc - Kriya Reward Token", b"rkriya.cc", b"Great news! Rewards for Kriya Finance are now live at https://rkriya.cc. Don't miss your chance to start earning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1729325947/rkriyacc_1019_0_ecgdye.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRIYAREWARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRIYAREWARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

