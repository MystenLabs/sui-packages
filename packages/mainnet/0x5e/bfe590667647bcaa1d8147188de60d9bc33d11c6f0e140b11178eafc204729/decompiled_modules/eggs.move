module 0x5ebfe590667647bcaa1d8147188de60d9bc33d11c6f0e140b11178eafc204729::eggs {
    struct EGGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGS>(arg0, 6, b"EGGS", b"SUI EGG PIXEL", x"5375692045676720506978656c2061206d656d6520746f6b656e206f6e2074686520737569206e6574776f726b210a656767206567672065676720656767", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/khbz2_Qb_E_400x400_c99e4dc7c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

