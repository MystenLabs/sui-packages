module 0x326a78cc815bfe5ee7fd421f8dfd8423bd2fd2329b120daf7dafa6b06c422f0a::agm {
    struct AGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGM>(arg0, 9, b"AGM", b"angry man", b"always be angry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9f26acb5ee054dd3063af8d14d1ea06fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

