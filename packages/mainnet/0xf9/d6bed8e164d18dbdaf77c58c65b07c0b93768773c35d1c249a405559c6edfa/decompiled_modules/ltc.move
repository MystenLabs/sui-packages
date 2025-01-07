module 0xf9d6bed8e164d18dbdaf77c58c65b07c0b93768773c35d1c249a405559c6edfa::ltc {
    struct LTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTC>(arg0, 6, b"LTC", b"Litecoin", b"Litecoin on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/litecoin_cb8aa02430.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

