module 0x20776aa06fa6d58cf83e3e854567198aebbd60cb24b8d75150e5597c52597171::mon {
    struct MON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MON>(arg0, 9, b"MON", b"borar", b"no", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0a467b4db0ba8a6f264a366a058f9130blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

