module 0xa26cdf4c957f003e73427aff5179d5e15005016d9089f3c79238b65826db06c8::ararat {
    struct ARARAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARARAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARARAT>(arg0, 9, b"ARARAT", b"$ARARAT", b"first Armenian coin ! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b277f83225a444ec4eb84de8453d4e56blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARARAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARARAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

