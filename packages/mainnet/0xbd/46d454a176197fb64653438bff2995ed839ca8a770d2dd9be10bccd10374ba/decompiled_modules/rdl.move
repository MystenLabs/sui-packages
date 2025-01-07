module 0xbd46d454a176197fb64653438bff2995ed839ca8a770d2dd9be10bccd10374ba::rdl {
    struct RDL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDL>(arg0, 9, b"RDL", b"REDBULL", b"REDBULL", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RDL>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RDL>>(v1);
    }

    // decompiled from Move bytecode v6
}

