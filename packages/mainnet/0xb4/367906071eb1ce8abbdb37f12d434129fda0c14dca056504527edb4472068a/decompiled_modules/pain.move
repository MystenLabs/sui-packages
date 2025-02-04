module 0xb4367906071eb1ce8abbdb37f12d434129fda0c14dca056504527edb4472068a::pain {
    struct PAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAIN>(arg0, 9, b"PAIN", b"Pain on Sui", b"NO $PAIN, NO GAIN. PAIN on Sui, official presale, the original $PAIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x330cf2276ac46f24d3d774e2e676b7da78fec37a.png?size=lg&key=df76ac")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PAIN>>(0x2::coin::mint<PAIN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PAIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

