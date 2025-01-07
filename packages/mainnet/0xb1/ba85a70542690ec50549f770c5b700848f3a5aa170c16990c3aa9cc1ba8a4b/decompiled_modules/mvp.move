module 0xb1ba85a70542690ec50549f770c5b700848f3a5aa170c16990c3aa9cc1ba8a4b::mvp {
    struct MVP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MVP>(arg0, 6, b"MVP", b"Most valuable token", x"4d6f73742076616c7561626c6520746f6b656e206f6e205375692e204e6f7468696e67206d6f72652c206e6f7468696e67206c6573730a0a536f6369616c733f205765276c6c207365650a0a5275673f204e6f7065", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/istockphoto_1415969967_612x612_90551e9229.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MVP>>(v1);
    }

    // decompiled from Move bytecode v6
}

