module 0xed2cc8aea20a78c5ad552d6f35a32a51cc6063a74f7662df2a9c750eb9046351::SUIPERCYCLE {
    struct SUIPERCYCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERCYCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERCYCLE>(arg0, 6, b"SUIPERCYCLE", b"SUIPERCYCLE", b"suipercycle(real) the denominator is worthless. infinite bid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://black-written-grasshopper-675.mypinata.cloud/ipfs/Qmf59ouLV9kXcji5TuK92ZepDbdbUdZ5am3UjxCckj58j3"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPERCYCLE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERCYCLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERCYCLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

