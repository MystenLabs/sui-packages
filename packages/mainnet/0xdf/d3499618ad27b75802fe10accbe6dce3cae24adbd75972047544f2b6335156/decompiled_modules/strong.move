module 0xdfd3499618ad27b75802fe10accbe6dce3cae24adbd75972047544f2b6335156::strong {
    struct STRONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRONG>(arg0, 6, b"Strong", b"Strong Token", b"I built this token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748523146132.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRONG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRONG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

