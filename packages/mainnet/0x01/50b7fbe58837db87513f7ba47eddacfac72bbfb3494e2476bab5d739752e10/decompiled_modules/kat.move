module 0x150b7fbe58837db87513f7ba47eddacfac72bbfb3494e2476bab5d739752e10::kat {
    struct KAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAT>(arg0, 9, b"KAT", b"katallina", b"lalalala", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d4a171ad06e4b23a267c26e6418019bdblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

