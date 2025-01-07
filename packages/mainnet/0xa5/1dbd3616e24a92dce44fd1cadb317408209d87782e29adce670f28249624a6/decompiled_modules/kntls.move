module 0xa51dbd3616e24a92dce44fd1cadb317408209d87782e29adce670f28249624a6::kntls {
    struct KNTLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNTLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNTLS>(arg0, 9, b"KNTLS", b"Kontl gede", b"Ngentoddd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82fc4097-9cdf-4edc-a6db-68a0ebfaec86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNTLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KNTLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

