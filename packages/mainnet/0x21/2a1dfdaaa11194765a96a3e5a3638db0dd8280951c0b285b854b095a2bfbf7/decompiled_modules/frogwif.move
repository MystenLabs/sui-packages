module 0x212a1dfdaaa11194765a96a3e5a3638db0dd8280951c0b285b854b095a2bfbf7::frogwif {
    struct FROGWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGWIF>(arg0, 6, b"FROGWIF", b"FROGWIFHAT", x"4a75737420666f72207468652063756c747572652e0a5a65726f205574696c6974792c206c696b652069742c206275792069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730952812618.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROGWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGWIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

