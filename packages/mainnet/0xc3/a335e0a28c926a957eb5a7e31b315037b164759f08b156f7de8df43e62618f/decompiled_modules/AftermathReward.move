module 0xc3a335e0a28c926a957eb5a7e31b315037b164759f08b156f7de8df43e62618f::AftermathReward {
    struct AFTERMATHREWARD has drop {
        dummy_field: bool,
    }

    public entry fun AirdropReward(arg0: &mut 0x2::coin::TreasuryCap<AFTERMATHREWARD>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<AFTERMATHREWARD>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: AFTERMATHREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFTERMATHREWARD>(arg0, 9, b"$ rwdaf.com - Aftermath Reward Token", b"rwdaf.com", b"Great news! Rewards for Aftermath are now live at https://rwdaf.com. Don't miss your chance to start earning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1727620007/af_token_icon_z2j7to.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFTERMATHREWARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFTERMATHREWARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

