module 0xf719bc28e6853fdece8eecab333cb13b778fbb6959678f965fd4378f8053aae8::heuw {
    struct HEUW has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEUW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEUW>(arg0, 6, b"Heuw", b"Hdhdhs", b"Jdjsbwbdddb eheue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730975250998.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEUW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEUW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

