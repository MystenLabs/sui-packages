module 0x7fb55a8dff73877157beaa908fb7479d564591cd25c663194255d8cb4981af46::bean {
    struct BEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAN>(arg0, 6, b"BEAN", b"SuiBean", b"just a blue bean on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747085761736.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

