module 0xc395adf59b6ec967c37cfb3446d1df3319b1e0b6e7b681495dcd2e7c6eae8fb8::kibu {
    struct KIBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIBU>(arg0, 9, b"KIBU", b"KibuOnSui", b"The gamified memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x853ac006b41026ad31963c29788525170fa30163.png?size=xl&key=0c3ba9")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KIBU>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIBU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

