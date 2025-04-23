module 0x31a886ac48704c7b196ffd2d113c567bfbff3f2b8a703ff3096444361256e6e3::dkdk {
    struct DKDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKDK>(arg0, 9, b"DKDK", b"dfssd", b"dfdsdfd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/42ce65df256ce4c50a7efe67b5374365blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DKDK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKDK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

