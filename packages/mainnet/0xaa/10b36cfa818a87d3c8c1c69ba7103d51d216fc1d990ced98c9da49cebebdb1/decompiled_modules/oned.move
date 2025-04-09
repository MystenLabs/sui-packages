module 0xaa10b36cfa818a87d3c8c1c69ba7103d51d216fc1d990ced98c9da49cebebdb1::oned {
    struct ONED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONED>(arg0, 9, b"ONED", b"ONE DOLLAR", b"JUST SPENT 1 Dollar !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4854d978d9642d4a45bbd47b3c8fc69eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

