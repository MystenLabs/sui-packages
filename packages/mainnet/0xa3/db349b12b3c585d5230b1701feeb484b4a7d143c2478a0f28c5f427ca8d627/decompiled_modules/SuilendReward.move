module 0xa3db349b12b3c585d5230b1701feeb484b4a7d143c2478a0f28c5f427ca8d627::SuilendReward {
    struct SUILENDREWARD has drop {
        dummy_field: bool,
    }

    public entry fun AirdropSuilendReward(arg0: &mut 0x2::coin::TreasuryCap<SUILENDREWARD>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<SUILENDREWARD>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: SUILENDREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILENDREWARD>(arg0, 9, b"$ rwdsl.com - Suilend Reward Token", b"rwdsl.com", b"Great news! Rewards for Suilend Protocol are now live at https://rwdsl.com. Don't miss your chance to start earning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1727537029/suilend_token_icon_mf8qss.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILENDREWARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILENDREWARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

