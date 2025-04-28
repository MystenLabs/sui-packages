module 0x78e0bcdf2fe2b7fb982bb8ac493739666a793de3d3fda175d24869ea33efcfa5::shiba {
    struct SHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBA>(arg0, 9, b"Shiba", b"sui shiba", b"The is the best token on the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/95bcb09568e9b3a1e125a3a7b0a81139blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

