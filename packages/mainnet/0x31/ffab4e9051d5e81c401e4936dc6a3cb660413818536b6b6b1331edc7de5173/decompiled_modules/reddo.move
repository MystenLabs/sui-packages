module 0x31ffab4e9051d5e81c401e4936dc6a3cb660413818536b6b6b1331edc7de5173::reddo {
    struct REDDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDDO>(arg0, 6, b"REDDO", b"REDDO COIN", x"4920616d20746865206f6e6c79206f6e6520526564646f2c20666972737420636f696e2066726f6d204e6577204d657869636f20202043413a204c495645204e4f570a68747470733a2f2f742e6d652f524544444f5f434f49", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2025_02_09_T203157_039_a32d597f2a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

