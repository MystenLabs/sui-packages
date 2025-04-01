module 0xbdec60749a8cdf73ae15d1d535c8a038aed95697cbc2bb042c02b44e4d6b88d3::ju65 {
    struct JU65 has drop {
        dummy_field: bool,
    }

    fun init(arg0: JU65, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JU65>(arg0, 9, b"JU65", b"stu", b"KYTU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0a75df009dd75990cf34adcb2f41340bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JU65>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JU65>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

