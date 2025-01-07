module 0xfd25ef478c9cae6ee0a945103996dce00b47e3a9841f262580776239608701d8::scarrot {
    struct SCARROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCARROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCARROT>(arg0, 9, b"SCARROT", b"Scarrot.MM", b"Vegetable for healthy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/feea8fc9-809a-459b-96f9-b22e86a13151.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCARROT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCARROT>>(v1);
    }

    // decompiled from Move bytecode v6
}

