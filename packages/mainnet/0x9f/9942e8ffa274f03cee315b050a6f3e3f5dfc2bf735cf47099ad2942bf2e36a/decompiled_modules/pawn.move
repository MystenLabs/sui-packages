module 0x9f9942e8ffa274f03cee315b050a6f3e3f5dfc2bf735cf47099ad2942bf2e36a::pawn {
    struct PAWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWN>(arg0, 1, b"Pawn", b"Pawn on sui", b"Pawn on sui is smt else", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWN>>(v1);
        0x2::coin::mint_and_transfer<PAWN>(&mut v2, 10000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

