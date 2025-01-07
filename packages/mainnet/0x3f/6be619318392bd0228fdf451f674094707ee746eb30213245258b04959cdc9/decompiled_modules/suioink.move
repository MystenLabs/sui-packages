module 0x3f6be619318392bd0228fdf451f674094707ee746eb30213245258b04959cdc9::suioink {
    struct SUIOINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOINK>(arg0, 6, b"Suioink", b"Oink", b"Get ready to dive the deep, chase the wealthy, and let $OINK take you to the moon! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010402_6e68086165.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIOINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

