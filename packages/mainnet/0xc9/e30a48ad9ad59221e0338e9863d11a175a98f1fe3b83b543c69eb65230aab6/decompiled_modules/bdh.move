module 0xc9e30a48ad9ad59221e0338e9863d11a175a98f1fe3b83b543c69eb65230aab6::bdh {
    struct BDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDH>(arg0, 6, b"BDH", b"bodoh", b".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732438380899.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

