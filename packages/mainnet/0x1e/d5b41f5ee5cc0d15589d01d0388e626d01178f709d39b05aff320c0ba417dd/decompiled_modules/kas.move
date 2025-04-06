module 0x1ed5b41f5ee5cc0d15589d01d0388e626d01178f709d39b05aff320c0ba417dd::kas {
    struct KAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAS>(arg0, 9, b"KAS", b"kasia", b"KAsia coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bc215d8d5bd5c8becd96e4c680822f9eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

