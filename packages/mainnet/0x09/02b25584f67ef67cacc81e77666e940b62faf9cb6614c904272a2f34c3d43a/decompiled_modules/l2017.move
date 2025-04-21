module 0x902b25584f67ef67cacc81e77666e940b62faf9cb6614c904272a2f34c3d43a::l2017 {
    struct L2017 has drop {
        dummy_field: bool,
    }

    fun init(arg0: L2017, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L2017>(arg0, 9, b"L2017", b"lev2017", b"ne wtoken my ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f94151cf61efa73ed877dd5cb14a9848blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L2017>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<L2017>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

