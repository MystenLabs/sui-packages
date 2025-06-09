module 0xe17dee13a660e5886215460c904bb07f6231684c73a0e815d1f1e8ec730a0bfe::brok {
    struct BROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROK>(arg0, 6, b"BROK", b"Brock", b"Brock is a trainer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749493030115.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

