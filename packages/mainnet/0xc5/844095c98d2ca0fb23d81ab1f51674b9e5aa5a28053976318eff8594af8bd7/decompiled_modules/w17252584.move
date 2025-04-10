module 0xc5844095c98d2ca0fb23d81ab1f51674b9e5aa5a28053976318eff8594af8bd7::w17252584 {
    struct W17252584 has drop {
        dummy_field: bool,
    }

    fun init(arg0: W17252584, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W17252584>(arg0, 9, b"W17252584", b"memgo", b"memgois VERYGOOD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9aaa14957ba10cc1c61edfa08379f133blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<W17252584>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<W17252584>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

