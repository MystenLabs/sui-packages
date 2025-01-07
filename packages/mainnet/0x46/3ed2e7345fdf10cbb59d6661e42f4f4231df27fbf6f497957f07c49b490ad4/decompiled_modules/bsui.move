module 0x463ed2e7345fdf10cbb59d6661e42f4f4231df27fbf6f497957f07c49b490ad4::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUI>(arg0, 9, b"BSUI", b"BlowFish on Sui", b"Website : https://www.blowfishsui.org .X: https://twitter.com/BlowFishonsui .Telegram: https://t.me/BlowFishOnSui .Docs: https://docs.blowfishsui.org/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.blowfishsui.org/images/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

