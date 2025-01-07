module 0x92a895a5aa4b9ca2405ed814ffbdad56a022c2106a46112e72148162865585e::gges {
    struct GGES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGES>(arg0, 6, b"GGES", b"ggnore", b"We like to run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732223362284.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

