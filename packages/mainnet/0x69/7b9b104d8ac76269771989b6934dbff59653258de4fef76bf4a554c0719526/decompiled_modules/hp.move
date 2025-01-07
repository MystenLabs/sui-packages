module 0x697b9b104d8ac76269771989b6934dbff59653258de4fef76bf4a554c0719526::hp {
    struct HP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HP>(arg0, 6, b"HP", b"Harry Putter", b"just Harry. just Putter.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4672581602770497_d28c287db2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HP>>(v1);
    }

    // decompiled from Move bytecode v6
}

