module 0x747127916db08fd08f3aae6f5928a88e08e35e75f2db8f71b6537aa71b0cd9ac::fourpointtwofive {
    struct FOURPOINTTWOFIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOURPOINTTWOFIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOURPOINTTWOFIVE>(arg0, 9, b"FOURPOINTTWOFIVE", b"BULLISH", b"The Fed just dropped rates to 4.25% and we're going to the moon!", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FOURPOINTTWOFIVE>>(0x2::coin::mint<FOURPOINTTWOFIVE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FOURPOINTTWOFIVE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FOURPOINTTWOFIVE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

