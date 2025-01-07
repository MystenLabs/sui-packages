module 0x5c589639d85b3bba044ca687b0e253082b7636515afda8855edeb5307fb4a9b8::nd {
    struct ND has drop {
        dummy_field: bool,
    }

    fun init(arg0: ND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ND>(arg0, 6, b"ND", b"Krazy N.D", b"$KRAZY is the wild alter ego ,  flipping the script with  instead of Andy's .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735956519113.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

