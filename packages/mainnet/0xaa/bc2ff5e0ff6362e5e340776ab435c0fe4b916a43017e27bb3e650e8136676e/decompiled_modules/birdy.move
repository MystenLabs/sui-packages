module 0xaabc2ff5e0ff6362e5e340776ab435c0fe4b916a43017e27bb3e650e8136676e::birdy {
    struct BIRDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDY>(arg0, 6, b"BIRDY", b"Pilot Birdy", b"You can fly with me, later you can see how high we can get through.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732008335353.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIRDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

