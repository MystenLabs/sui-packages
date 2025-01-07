module 0x9cdba663f0d08cf69ea219102adf0181841c49e17960702bd8182dd7c4e326ac::strump {
    struct STRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRUMP>(arg0, 6, b"Strump", b"sui trump", b"no twitter,no telegram,no website, just fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731073445088.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

