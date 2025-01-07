module 0x23cd7fb46c2b221bdf34e0ad8edf0d470e210fb238e8ece12ee6f4ebaa54fdb3::trump312 {
    struct TRUMP312 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP312, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP312>(arg0, 6, b"TRUMP312", b"TRUMP 312 VOTES", x"5472756d7020776f6e20746865203437746820707265736964656e7420776974682033313220656c6563746f72616c20766f7465730a0a4d616b6520416d657269636120477265617420416761696e0a0a0a4d616b65205472756d7020477265617420416761696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730946000801.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP312>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP312>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

