module 0x770b1b0344a1ffd00b489af3cbc0f5196a623f238619341c956206b1530ad4f8::dtm {
    struct DTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTM>(arg0, 6, b"DTM", b"DOGTOMOON", b"The people voted for major reform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/5cdbfc83-79b4-4fa7-a334-1fe1fce339d6.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DTM>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

