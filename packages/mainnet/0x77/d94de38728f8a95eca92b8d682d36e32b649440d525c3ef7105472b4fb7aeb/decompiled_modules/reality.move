module 0x77d94de38728f8a95eca92b8d682d36e32b649440d525c3ef7105472b4fb7aeb::reality {
    struct REALITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: REALITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REALITY>(arg0, 6, b"REALITY", b"Reality", x"54686520776f726c64206f7220746865207374617465206f66207468696e677320617320746865792061637475616c6c792065786973742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736227026243.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REALITY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REALITY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

