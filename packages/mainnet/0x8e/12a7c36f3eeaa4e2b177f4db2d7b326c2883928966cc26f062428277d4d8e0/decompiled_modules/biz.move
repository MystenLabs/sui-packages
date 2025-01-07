module 0x8e12a7c36f3eeaa4e2b177f4db2d7b326c2883928966cc26f062428277d4d8e0::biz {
    struct BIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIZ>(arg0, 6, b"BIZ", b"Bizkit", b"Introducing Bizkit the SUI-TZU. The cutest dog on $SUI .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731766950757.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

