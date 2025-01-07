module 0x748e8fb9ed4d9aa996cfaf778568d13e839be8bea903d9b667bf1817080d820e::kumabe {
    struct KUMABE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUMABE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUMABE>(arg0, 6, b"KUMABE", b"Kungfu Master Beaver", b"Kungfu Master Beaver On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731043045659.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUMABE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUMABE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

