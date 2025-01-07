module 0x54dfaf6d473738988b88ae77eb2b9f900654c9bd3eb113119aa04c370fa09ddb::beerbeer {
    struct BEERBEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEERBEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEERBEER>(arg0, 9, b"BEERBEER", b"Beer", b"Everyone loves beer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dafa04c9-67db-4059-94cf-c0a7ce2b5d78.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEERBEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEERBEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

