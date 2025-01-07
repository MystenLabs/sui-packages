module 0x55f9ddbab39c01e43a5bc0f2a8f6a6a5e48d06b6b1a548082b130ba9f2d460e1::tsuip {
    struct TSUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUIP>(arg0, 6, b"TSUIP", b"TRUMP ON SUI", x"54535549502069732061206e6577206d656d6520746f6b656e2063726561746564206f6e207468652053756920626c6f636b636861696e20696e20737570706f7274206f6620446f6e616c64205472756d702e0a0a546865206e616d6520e280985453554950e2809920636f6d62696e6573205472756d7027732073796d626f6c69736d20616e6420796f75746820736c616e6720746f20656d70686173697365207468652069646561206f662061207374726f6e6720616e64206f726967696e616c20617070726f61636820746f20706f6c69746963732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950239766.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSUIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

