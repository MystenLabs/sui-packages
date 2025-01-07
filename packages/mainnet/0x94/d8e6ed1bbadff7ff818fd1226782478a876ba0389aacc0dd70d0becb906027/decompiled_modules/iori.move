module 0x94d8e6ed1bbadff7ff818fd1226782478a876ba0389aacc0dd70d0becb906027::iori {
    struct IORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IORI>(arg0, 9, b"IORI", b"iori coin", b"1000000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f59f60ef65fdefac50bb45a9385a336eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IORI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IORI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

