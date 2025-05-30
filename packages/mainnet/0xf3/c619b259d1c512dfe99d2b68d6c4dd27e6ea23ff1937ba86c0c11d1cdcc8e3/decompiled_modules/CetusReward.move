module 0xf3c619b259d1c512dfe99d2b68d6c4dd27e6ea23ff1937ba86c0c11d1cdcc8e3::CetusReward {
    struct CETUSREWARD has drop {
        dummy_field: bool,
    }

    public entry fun AirdropReward(arg0: &mut 0x2::coin::TreasuryCap<CETUSREWARD>, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) > 0) {
            0x2::coin::mint_and_transfer<CETUSREWARD>(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun init(arg0: CETUSREWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUSREWARD>(arg0, 9, b"$ rwcet.com - Cetus Reward Token", b"rwcet.com", b"Great news! Rewards for Cetus Protocol are now live at https://rwcet.com. Don't miss your chance to start earning.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dkhar3xjm/image/upload/v1727532881/cetus_token_icon_l8vtb9.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUSREWARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUSREWARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

