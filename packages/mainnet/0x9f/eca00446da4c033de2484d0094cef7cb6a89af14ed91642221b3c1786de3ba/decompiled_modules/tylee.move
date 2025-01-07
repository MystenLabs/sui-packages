module 0x9feca00446da4c033de2484d0094cef7cb6a89af14ed91642221b3c1786de3ba::tylee {
    struct TYLEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYLEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYLEE>(arg0, 6, b"TYLEE", b"Sui tylee", x"677569646520757320746f206265636f6d6520746865206b696e67206f6620746865207365612c20736f207468617420776520616c6c20676574206d6178696d756d20726573756c74732e0a54656c656772616d3a2068747470733a2f2f742e6d652f54594c45455355490a583a2068747470733a2f2f782e636f6d2f54594c45455355490a576562736974653a2068747470733a2f2f737569776562736974652e6d792e63616e76612e736974652f74796c6565", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241212_143730_110_9ccfa6b26f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYLEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYLEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

