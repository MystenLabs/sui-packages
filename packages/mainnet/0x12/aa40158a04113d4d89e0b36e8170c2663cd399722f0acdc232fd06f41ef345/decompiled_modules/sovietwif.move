module 0x12aa40158a04113d4d89e0b36e8170c2663cd399722f0acdc232fd06f41ef345::sovietwif {
    struct SOVIETWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOVIETWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOVIETWIF>(arg0, 6, b"SOVIETWIF", b"Soviet Dog Wif Hat", b"cykablyat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sovietdogwiftg_9d55944982.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOVIETWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOVIETWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

