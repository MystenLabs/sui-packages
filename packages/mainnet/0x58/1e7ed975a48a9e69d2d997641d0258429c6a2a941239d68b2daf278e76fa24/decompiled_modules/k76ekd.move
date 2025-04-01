module 0x581e7ed975a48a9e69d2d997641d0258429c6a2a941239d68b2daf278e76fa24::k76ekd {
    struct K76EKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: K76EKD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<K76EKD>(arg0, 9, b"K76EKD", b"54h", b"dty68u", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b5c390dfa9c18becbec042ae1eb146aeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<K76EKD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<K76EKD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

