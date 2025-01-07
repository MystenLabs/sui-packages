module 0x376b28de44d3a125d848381c133d526716a9d161d9fcc13145f103b03468f86a::bdl {
    struct BDL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDL>(arg0, 9, b"BDL", b"Bandwidth Limit", b"Escape the bandwidth limit with SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/660449cc0e9aedf87a3c9f18120d2c7bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

