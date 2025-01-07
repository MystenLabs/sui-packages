module 0x4544c489c212f33c56b79d37a6f0dfc1099a0c58516b8be16592f2b2ba6e7b69::suifin {
    struct SUIFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFIN>(arg0, 6, b"SuiFin", b"SuiFin Wavecrest", x"53756966696e205761766563726573743a204120667574757269737469632c20706c617966756c20646f6c7068696e20726570726573656e74696e6720535549e280997320696e6e6f766174696f6e20616e6420666c7569646974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732855514785.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

