module 0x6d7881d6844d3f7523287eac435f838db0b378035213aeeb511d7155e5e0e364::comst {
    struct COMST has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMST>(arg0, 9, b"COMST", b"communication tutorial and survey", b"Let FOMO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/193896bd2b5f2671bbc9ebbf89f3f1a5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

