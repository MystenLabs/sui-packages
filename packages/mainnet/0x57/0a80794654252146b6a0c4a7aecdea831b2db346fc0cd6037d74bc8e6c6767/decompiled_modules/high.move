module 0x570a80794654252146b6a0c4a7aecdea831b2db346fc0cd6037d74bc8e6c6767::high {
    struct HIGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIGH>(arg0, 6, b"HIGH", b"Highland Cow", b"Highland Cow says Sui is going to the moooooooooon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731612352415.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIGH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIGH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

