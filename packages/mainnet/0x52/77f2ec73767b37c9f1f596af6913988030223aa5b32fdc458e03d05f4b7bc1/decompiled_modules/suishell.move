module 0x5277f2ec73767b37c9f1f596af6913988030223aa5b32fdc458e03d05f4b7bc1::suishell {
    struct SUISHELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHELL>(arg0, 6, b"SUISHELL", b"Sui Shell", b"Listen closely  $SUISHELL carries the voice of the Sui seas. A delicate yet powerful token, it holds the secrets of the deep and the calm of the tides. Pick it up and let the magic of the Sui ocean speak to you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sea_Shell_c99faa39e7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

