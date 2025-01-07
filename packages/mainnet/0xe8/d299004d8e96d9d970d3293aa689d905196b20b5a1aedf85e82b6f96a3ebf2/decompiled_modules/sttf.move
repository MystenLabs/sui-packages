module 0xe8d299004d8e96d9d970d3293aa689d905196b20b5a1aedf85e82b6f96a3ebf2::sttf {
    struct STTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: STTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STTF>(arg0, 6, b"STTF", b"SUIToTheFuture", b"Sui To The Future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_e8ec516c36.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STTF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STTF>>(v1);
    }

    // decompiled from Move bytecode v6
}

