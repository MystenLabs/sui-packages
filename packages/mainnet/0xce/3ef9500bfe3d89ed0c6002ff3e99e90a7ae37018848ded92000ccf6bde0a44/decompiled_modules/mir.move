module 0xce3ef9500bfe3d89ed0c6002ff3e99e90a7ae37018848ded92000ccf6bde0a44::mir {
    struct MIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIR>(arg0, 9, b"MIR", b"MIRIAM", b"TROIA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIR>(&mut v2, 5492000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

