module 0x495fb868863018e4b2f5e73e9774d63d6e7ee33a60637dced80481b8292a59cf::freak {
    struct FREAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREAK>(arg0, 6, b"Freak", b"FREAKY", b"Be weird. Be wild. Be $FREAK.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigwfi35rrmdqezyvgwf6ydgx2c5gef4zpkhlz25wvfvbx3dvpqnkq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FREAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

