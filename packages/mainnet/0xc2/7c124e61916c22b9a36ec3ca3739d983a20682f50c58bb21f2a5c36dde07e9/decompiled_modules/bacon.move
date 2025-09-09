module 0xc27c124e61916c22b9a36ec3ca3739d983a20682f50c58bb21f2a5c36dde07e9::bacon {
    struct BACON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACON>(arg0, 9, b"BACON", b"SUI BACON", x"4372697370792c207363617263652c206172746973616e616c20637574732e204f6e6c7920312c3030302c303030207374726970732065766572207365727665642e204241434f4e206f6e2053554920e280932042656361757365206576657279206d65616c206973206265747465722077697468204241434f4e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/Qmc4KWrgHXcqomMWXwBnnLmtSTUjNCtdC8WGcRF435qeAv")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BACON>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BACON>>(v1);
    }

    // decompiled from Move bytecode v6
}

