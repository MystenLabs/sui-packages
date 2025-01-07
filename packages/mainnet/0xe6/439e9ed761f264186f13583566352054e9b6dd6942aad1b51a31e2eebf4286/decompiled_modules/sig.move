module 0xe6439e9ed761f264186f13583566352054e9b6dd6942aad1b51a31e2eebf4286::sig {
    struct SIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIG>(arg0, 6, b"SIG", b"SIG SUI", x"5349472063616e2062652077686f657665722068652077616e74733a207468652062616c642c2074686520746573746f737465726f6e652068616972792c206275742053494720616c776179732063686f6f736573206265696e6720612077696e6e6572206f6e205355492e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_be8c4041b6_d303249bfc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

