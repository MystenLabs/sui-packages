module 0x7cc32233e97c293c6e70c23a61f2f82e513ef7d546c93b04db2446a35e6ec0d1::pati {
    struct PATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATI>(arg0, 6, b"Pati", b"Patriot", b"Father, husband, patriot ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731501443826.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PATI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

