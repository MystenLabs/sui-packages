module 0x6ee4346475841429c15559df51f07c332800bf11addb52b53bdee9d36ac7200e::bobe {
    struct BOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBE>(arg0, 6, b"BOBE", b"Bobe on Sui", b"BOBE the Turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730985093969.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

