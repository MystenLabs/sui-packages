module 0x8478dfe5326b9a78af1682160c041f9d4b3736f3594c06b1c3ccbbf887e487b1::syc {
    struct SYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYC>(arg0, 6, b"SYC", b"Suiyan Cat", b"the most annoying cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_CQH_40b_UAA_3_MQR_4d3e385f75.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYC>>(v1);
    }

    // decompiled from Move bytecode v6
}

