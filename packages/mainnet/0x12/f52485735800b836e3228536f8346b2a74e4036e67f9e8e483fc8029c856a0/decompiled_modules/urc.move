module 0x12f52485735800b836e3228536f8346b2a74e4036e67f9e8e483fc8029c856a0::urc {
    struct URC has drop {
        dummy_field: bool,
    }

    fun init(arg0: URC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URC>(arg0, 6, b"URC", b"UrCristiano", b"UrCristiano fan token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241124_011445_516_f57718a1ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<URC>>(v1);
    }

    // decompiled from Move bytecode v6
}

