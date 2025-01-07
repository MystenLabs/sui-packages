module 0xa7a6ef3ef1533ec74f74c93bc1f5d24480e64948f3c62134b7e46212bd2c5b8::swf {
    struct SWF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWF>(arg0, 6, b"SWF", b"santawifhat", b"Was the dog wif hat nice this year? Santa is coming!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732802363591.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

