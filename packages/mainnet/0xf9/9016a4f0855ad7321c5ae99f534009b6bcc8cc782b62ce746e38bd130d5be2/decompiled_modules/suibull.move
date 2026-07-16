module 0xf99016a4f0855ad7321c5ae99f534009b6bcc8cc782b62ce746e38bd130d5be2::suibull {
    struct SUIBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBULL>(arg0, 6, b"SUIBULL", b"The Sui Bull", b"The Blue Bull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1784161645101.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBULL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

