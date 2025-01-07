module 0x4c8b439730cd22ceeefce0a0c43db73fead9958486a7949dcd735a2fada5794a::suiman {
    struct SUIMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAN>(arg0, 6, b"SUIMAN", b"Suiman", x"5355494d414e204f4e20484953205741590a544f20534156452043525950544f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731012498848.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

