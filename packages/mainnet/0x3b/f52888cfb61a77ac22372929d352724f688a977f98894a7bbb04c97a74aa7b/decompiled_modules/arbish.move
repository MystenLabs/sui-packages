module 0x3bf52888cfb61a77ac22372929d352724f688a977f98894a7bbb04c97a74aa7b::arbish {
    struct ARBISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARBISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARBISH>(arg0, 6, b"ARBISH", b"$ARBISH", x"53617920686920746f20244152424953482c2074686520726562656c2070757020627265616b696e6720616c6c207468652072756c65732e200a0a68747470733a2f2f7777772e6172626973682e696f2f0a68747470733a2f2f782e636f6d2f617262697368646f670a68747470733a2f2f742e6d652f6172626973685f706f7274616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731014800404.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARBISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARBISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

