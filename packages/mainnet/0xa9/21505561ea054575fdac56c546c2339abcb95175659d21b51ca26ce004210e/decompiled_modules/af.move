module 0xa921505561ea054575fdac56c546c2339abcb95175659d21b51ca26ce004210e::af {
    struct AF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AF>(arg0, 6, b"AF", b"America First", x"416d65726963612046697273740a0a4a757374204d616b6520416d657269636120477265617420416761696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730688740246.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

