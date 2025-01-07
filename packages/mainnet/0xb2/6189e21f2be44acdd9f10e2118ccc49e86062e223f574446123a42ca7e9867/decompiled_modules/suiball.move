module 0xb26189e21f2be44acdd9f10e2118ccc49e86062e223f574446123a42ca7e9867::suiball {
    struct SUIBALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBALL>(arg0, 9, b"SUIBALL", b"SUIBALL", b"SUI BALL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBALL>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBALL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

