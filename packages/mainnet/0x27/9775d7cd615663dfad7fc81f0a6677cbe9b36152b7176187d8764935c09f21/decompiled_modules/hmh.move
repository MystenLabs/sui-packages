module 0x279775d7cd615663dfad7fc81f0a6677cbe9b36152b7176187d8764935c09f21::hmh {
    struct HMH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMH>(arg0, 9, b"HMH", b"HAMAHA", b"GUY WHO MANIPULATE WORLD, BITCOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/912b18894a0d04e1e733f49eb63d5066blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

