module 0xb9f6e75f85cc94057707335c6283133f39d851dbe883b230777dbccdccf226b0::shoe {
    struct SHOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOE>(arg0, 9, b"SHOE", b"Shoes", b"Ethygg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0dcefe51-cf97-4723-842a-ac6860cce724.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

