module 0x697e36b566117978ee285b7d0f0e4ae784b8ba2c67df420f72cd509158204daf::suite {
    struct SUITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITE>(arg0, 9, b"SUITE", b"Golden-Huge-SUIte", b"This market is going so goood, you will be in your favourtie SUIte if you buy this shit now!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c116fd1d9b4400b38f29a174f0341132blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

