module 0xb61f6a9515c6176e24b1b7b3f7fcafde204cffc3daee565ea14ac29cc8b3ed6f::wisp {
    struct WISP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WISP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WISP>(arg0, 6, b"WISP", b"100M WISP", x"4e65772063686172616374657220696e20535549e29c85546865206d656d6520746861742077696c6c2062652061207472656e6420696e20746865205355492065636f73797374656df09f9388", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734910839340.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WISP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WISP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

