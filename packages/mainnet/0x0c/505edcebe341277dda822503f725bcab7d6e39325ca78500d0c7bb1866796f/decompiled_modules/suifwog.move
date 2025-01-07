module 0xc505edcebe341277dda822503f725bcab7d6e39325ca78500d0c7bb1866796f::suifwog {
    struct SUIFWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFWOG>(arg0, 6, b"SuiFwog", b"Sui Fwog", b"The cute and lovely Fwog is coming to Sui forest.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://suifwog.xyz/images/suifwog_icon.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIFWOG>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFWOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFWOG>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

