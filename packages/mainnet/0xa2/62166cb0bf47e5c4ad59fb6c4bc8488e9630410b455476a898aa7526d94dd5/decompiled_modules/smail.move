module 0xa262166cb0bf47e5c4ad59fb6c4bc8488e9630410b455476a898aa7526d94dd5::smail {
    struct SMAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAIL>(arg0, 6, b"SMAIL", b"SuiMail", x"4120646563656e7472616c697a6564206d61696c696e672073797374656d206f6e200a405375696e6574776f726b0a20e2809420666f72207365637572652c20707269766174652c20616e642063656e736f72736869702d6672656520656d61696c732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749656671594.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMAIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

