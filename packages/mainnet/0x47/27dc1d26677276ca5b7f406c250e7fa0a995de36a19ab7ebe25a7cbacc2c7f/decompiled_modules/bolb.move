module 0x4727dc1d26677276ca5b7f406c250e7fa0a995de36a19ab7ebe25a7cbacc2c7f::bolb {
    struct BOLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLB>(arg0, 6, b"BOLB", b"BOLB SUI", b"BOLB BOLB BOLB BOLB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7936_9d7eeb1820.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

