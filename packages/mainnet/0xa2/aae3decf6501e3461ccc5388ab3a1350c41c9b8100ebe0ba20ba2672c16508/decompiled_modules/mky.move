module 0xa2aae3decf6501e3461ccc5388ab3a1350c41c9b8100ebe0ba20ba2672c16508::mky {
    struct MKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKY>(arg0, 0, b"MKY", b"monkey", b"monkey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JRRevxj.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<MKY>(&mut v2, 1000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKY>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

