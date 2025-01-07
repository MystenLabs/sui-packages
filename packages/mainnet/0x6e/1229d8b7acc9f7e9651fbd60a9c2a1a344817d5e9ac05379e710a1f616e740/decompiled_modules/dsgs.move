module 0x6e1229d8b7acc9f7e9651fbd60a9c2a1a344817d5e9ac05379e710a1f616e740::dsgs {
    struct DSGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSGS>(arg0, 9, b"DSGS", b"safsaf", b"GFRGH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/119ddce9-4306-42c6-aca7-841dac8a234a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

