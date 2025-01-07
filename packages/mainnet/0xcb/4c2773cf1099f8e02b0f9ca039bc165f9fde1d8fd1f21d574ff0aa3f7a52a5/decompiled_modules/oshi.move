module 0xcb4c2773cf1099f8e02b0f9ca039bc165f9fde1d8fd1f21d574ff0aa3f7a52a5::oshi {
    struct OSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSHI>(arg0, 9, b"Oshi", b"Oshi", b"Readly for Oshi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.fbcd.co/products/resized/resized-750-500/naj21-11-45347b4f1241e9f7de8eca4c7c398030e871dbb3c4b1c8386d31124a968c312a.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OSHI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSHI>>(v2, @0x3e6f93f81e9cc2660e8eb52283f5c8c06c04abc6920ffa99bd849d3da0ddccee);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

