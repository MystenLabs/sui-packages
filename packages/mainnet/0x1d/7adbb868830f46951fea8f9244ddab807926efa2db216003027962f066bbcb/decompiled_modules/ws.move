module 0x1d7adbb868830f46951fea8f9244ddab807926efa2db216003027962f066bbcb::ws {
    struct WS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WS>(arg0, 9, b"WS", b"WeweSui", b"0xbe3273404f2a2a28b99bc225f0fe5b3142e63c5334ea8a2b8f377df1f9482c00", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18ee185e-68bb-460f-ad6c-2ba7049a7ed5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WS>>(v1);
    }

    // decompiled from Move bytecode v6
}

