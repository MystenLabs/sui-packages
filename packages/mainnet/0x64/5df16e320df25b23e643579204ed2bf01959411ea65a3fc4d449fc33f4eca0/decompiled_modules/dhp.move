module 0x645df16e320df25b23e643579204ed2bf01959411ea65a3fc4d449fc33f4eca0::dhp {
    struct DHP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHP>(arg0, 6, b"DHP", b"dahap", b"Perhaps God will do something after that.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731491307421.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DHP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

