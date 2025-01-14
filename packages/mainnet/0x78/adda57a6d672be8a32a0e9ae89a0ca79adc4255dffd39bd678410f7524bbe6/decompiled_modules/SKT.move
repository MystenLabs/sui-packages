module 0x78adda57a6d672be8a32a0e9ae89a0ca79adc4255dffd39bd678410f7524bbe6::SKT {
    struct SKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKT>(arg0, 6, b"X", b"X", b"X token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://de.fi/test.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

