module 0xb2040456be6b1b16835cc32b2fe2b1dc4b55c8a9b3cab6fb962f06b570f4645c::SuiReward {
    struct SUIREWARD has drop {
        dummy_field: bool,
    }

    public entry fun AirdropReward(arg0: &mut 0x2::coin::TreasuryCap<SUIREWARD>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<SUIREWARD>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: SUIREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREWARD>(arg0, 9, b"$ rwsui.com - Sui Reward Token", b"rwsui.com", b"Great news! Rewards for Sui Network are now live at https://rwsui.com. Don't miss your chance to start earning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1728746582/rwsuicom__rgfu0h.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIREWARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREWARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

