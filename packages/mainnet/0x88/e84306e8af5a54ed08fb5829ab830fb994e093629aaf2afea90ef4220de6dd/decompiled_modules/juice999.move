module 0x88e84306e8af5a54ed08fb5829ab830fb994e093629aaf2afea90ef4220de6dd::juice999 {
    struct JUICE999 has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUICE999, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUICE999>(arg0, 6, b"Juice999", b"Juiceworld", b"Juiceworld 4ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732940637331.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUICE999>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUICE999>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

