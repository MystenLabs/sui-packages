module 0x9eeb105ed48960010d7f3b29e8ac94f1bda287214a8911be187724ed1d6d3401::ct {
    struct CT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CT>(arg0, 9, b"CT", b"cat", b"xddddd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/715846f512aa0e4b61844e24ce0975c2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

