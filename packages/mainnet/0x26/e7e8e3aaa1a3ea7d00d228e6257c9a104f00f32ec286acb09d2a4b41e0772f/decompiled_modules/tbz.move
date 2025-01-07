module 0x26e7e8e3aaa1a3ea7d00d228e6257c9a104f00f32ec286acb09d2a4b41e0772f::tbz {
    struct TBZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBZ>(arg0, 9, b"TBZ", b"TEBLEZED", b"I see you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46ef1808-1375-45ac-8e80-8ebad2785d24.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TBZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

