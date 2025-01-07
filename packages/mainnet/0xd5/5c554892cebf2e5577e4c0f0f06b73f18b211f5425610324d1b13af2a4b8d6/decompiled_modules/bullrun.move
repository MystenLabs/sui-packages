module 0xd55c554892cebf2e5577e4c0f0f06b73f18b211f5425610324d1b13af2a4b8d6::bullrun {
    struct BULLRUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLRUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLRUN>(arg0, 9, b"BULLRUN", b"Bull ", b"Bull market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/13821c19-1842-456c-8586-bb2f5b57be0d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLRUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLRUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

