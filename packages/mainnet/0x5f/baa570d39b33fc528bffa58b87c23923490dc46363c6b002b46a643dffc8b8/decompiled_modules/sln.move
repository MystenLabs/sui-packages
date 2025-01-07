module 0x5fbaa570d39b33fc528bffa58b87c23923490dc46363c6b002b46a643dffc8b8::sln {
    struct SLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLN>(arg0, 6, b"SLN", b"Suilion", b"colony of suilions taking over sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/silion_cfc9d13b49.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

