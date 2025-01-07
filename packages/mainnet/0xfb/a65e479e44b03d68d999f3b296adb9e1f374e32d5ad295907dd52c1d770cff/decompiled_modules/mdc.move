module 0xfba65e479e44b03d68d999f3b296adb9e1f374e32d5ad295907dd52c1d770cff::mdc {
    struct MDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDC>(arg0, 9, b"MDC_test", b"MDCCn", b"MDC Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static-file.cubicgames.xyz/cubic_icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDC>>(v1);
        0x2::coin::mint_and_transfer<MDC>(&mut v2, 1000000000000000000, @0xc8008f590b556643edebfd9bd1ca9e64894007ad0536df70b0d845ff5d8db73, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDC>>(v2, @0xc8008f590b556643edebfd9bd1ca9e64894007ad0536df70b0d845ff5d8db73);
    }

    // decompiled from Move bytecode v6
}

