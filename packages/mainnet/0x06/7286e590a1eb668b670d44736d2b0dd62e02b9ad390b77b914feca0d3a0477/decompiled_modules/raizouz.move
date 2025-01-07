module 0x67286e590a1eb668b670d44736d2b0dd62e02b9ad390b77b914feca0d3a0477::raizouz {
    struct RAIZOUZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAIZOUZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAIZOUZ>(arg0, 9, b"RAIZOUZ", b"Raizou", b"Buy to x1000000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f156149d-63cb-444a-9ae6-867aa774610e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAIZOUZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAIZOUZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

