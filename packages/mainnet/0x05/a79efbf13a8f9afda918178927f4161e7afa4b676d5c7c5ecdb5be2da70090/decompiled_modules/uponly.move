module 0x5a79efbf13a8f9afda918178927f4161e7afa4b676d5c7c5ecdb5be2da70090::uponly {
    struct UPONLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPONLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPONLY>(arg0, 6, b"UPONLY", b"UP ONLY", b"WE GO UP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731036010369.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UPONLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPONLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

