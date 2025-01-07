module 0x150dbee3737454f89045d7850e8fb1e67220517ce8da8ed8bc05d02825573f39::greyon {
    struct GREYON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREYON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREYON>(arg0, 6, b"Greyon", b"SUI Grey", b"Please don't hesitate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1afafb24a3abbd7c_b2914b8664.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREYON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREYON>>(v1);
    }

    // decompiled from Move bytecode v6
}

