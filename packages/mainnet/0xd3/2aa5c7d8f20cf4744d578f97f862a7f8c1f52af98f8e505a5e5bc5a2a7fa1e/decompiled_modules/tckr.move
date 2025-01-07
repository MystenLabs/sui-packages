module 0xd32aa5c7d8f20cf4744d578f97f862a7f8c1f52af98f8e505a5e5bc5a2a7fa1e::tckr {
    struct TCKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCKR>(arg0, 9, b"TCKR", b"Tucker", b"TUCKER Carlson fans", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af0cd8bb-7f00-43ef-bddd-ad5a796e2a5c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCKR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCKR>>(v1);
    }

    // decompiled from Move bytecode v6
}

