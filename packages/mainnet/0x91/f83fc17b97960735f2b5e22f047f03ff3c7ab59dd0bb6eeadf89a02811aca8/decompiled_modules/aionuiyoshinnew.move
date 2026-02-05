module 0x91f83fc17b97960735f2b5e22f047f03ff3c7ab59dd0bb6eeadf89a02811aca8::aionuiyoshinnew {
    struct AIONUIYOSHINNEW has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<AIONUIYOSHINNEW>, arg1: 0x2::coin::Coin<AIONUIYOSHINNEW>) {
        0x2::coin::burn<AIONUIYOSHINNEW>(arg0, arg1);
    }

    fun init(arg0: AIONUIYOSHINNEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIONUIYOSHINNEW>(arg0, 6, b"AionUiyoshinnew", b"AionUiyoshinnew", b"AionUiyoshinnew", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIONUIYOSHINNEW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIONUIYOSHINNEW>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIONUIYOSHINNEW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AIONUIYOSHINNEW>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

