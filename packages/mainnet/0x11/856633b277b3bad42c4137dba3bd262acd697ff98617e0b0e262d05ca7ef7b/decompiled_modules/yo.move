module 0x11856633b277b3bad42c4137dba3bd262acd697ff98617e0b0e262d05ca7ef7b::yo {
    struct YO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YO>(arg0, 9, b"Yo", b"Yojo", b"M3m", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YO>>(v1);
    }

    // decompiled from Move bytecode v6
}

