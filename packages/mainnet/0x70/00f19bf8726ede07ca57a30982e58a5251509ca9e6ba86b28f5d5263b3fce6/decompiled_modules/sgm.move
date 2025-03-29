module 0x7000f19bf8726ede07ca57a30982e58a5251509ca9e6ba86b28f5d5263b3fce6::sgm {
    struct SGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGM>(arg0, 9, b"SGM", b"supergemer", b",m", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/05400f2db6d306aafc2733f75c1116aeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

