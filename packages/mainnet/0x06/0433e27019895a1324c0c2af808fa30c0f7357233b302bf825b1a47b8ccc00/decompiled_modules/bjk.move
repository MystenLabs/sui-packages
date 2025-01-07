module 0x60433e27019895a1324c0c2af808fa30c0f7357233b302bf825b1a47b8ccc00::bjk {
    struct BJK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BJK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BJK>(arg0, 6, b"BJK", b"benjake", b"Ai Agent who trades and swaps in |Dex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_1005_846b14a206.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BJK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BJK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

