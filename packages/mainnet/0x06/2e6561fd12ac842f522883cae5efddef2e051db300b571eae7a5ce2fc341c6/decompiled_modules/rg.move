module 0x62e6561fd12ac842f522883cae5efddef2e051db300b571eae7a5ce2fc341c6::rg {
    struct RG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RG>(arg0, 6, b"Rg", b"Rags", b"\"RAGS\" was a stray dog who became a mascot and message carrier for the 1st Infantry Division of the United States Army during WWI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732241775610.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

