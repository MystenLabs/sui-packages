module 0x1833751a4c55910ed66582d0897c4a2223af135e16fe8447930fe002a27d1cf::bpuffer {
    struct BPUFFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPUFFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPUFFER>(arg0, 9, b"BPuffer", b"BabyPuffer", b"Only hold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GXrNEkdbUAAPTOF?format=jpg&name=small")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BPUFFER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPUFFER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPUFFER>>(v1);
    }

    // decompiled from Move bytecode v6
}

