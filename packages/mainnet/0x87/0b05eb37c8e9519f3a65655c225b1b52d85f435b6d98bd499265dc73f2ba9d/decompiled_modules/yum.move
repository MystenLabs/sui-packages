module 0x870b05eb37c8e9519f3a65655c225b1b52d85f435b6d98bd499265dc73f2ba9d::yum {
    struct YUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUM>(arg0, 6, b"YUM", b"Yummy", x"59756d207468652066636b206f7574202459554d0a707574206f6e20796f757220535549676c6173736573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730986796059.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

