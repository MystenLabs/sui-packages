module 0xd2ad4f814878e713673deee23a90d7336939e30de1fdb4a103098713bf392a8b::plg {
    struct PLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLG>(arg0, 9, b"PLG", b"Polygon", b"pol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/633f1d8ad8caff6829f8d91918e6808bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

