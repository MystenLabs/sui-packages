module 0x7ceda4424dee50c20f5333eab99ddacc301da03f7f683cf831b50768e696be26::ttm {
    struct TTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTM>(arg0, 6, b"TTM", b"Totem AI", x"4120736163726564206761746577617920746f20666f72676520796f7572206f776e20736f7665726569676e20737069726974202620636f736d69632064617368626f6172642e2041636365737320616e6369656e7420776973646f6d2c207175616e74756d20636f6d6d756e69746965732c20616e6420696e66696e697465207265616c6d732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735909766615.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

