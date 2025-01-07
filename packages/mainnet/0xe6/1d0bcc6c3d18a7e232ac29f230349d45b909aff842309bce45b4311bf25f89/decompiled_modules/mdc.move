module 0xe61d0bcc6c3d18a7e232ac29f230349d45b909aff842309bce45b4311bf25f89::mdc {
    struct MDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDC>(arg0, 9, b"MDC", b"MDC", b"MDC Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://download.sui-mermaid.io/mdc.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDC>>(v1);
        0x2::coin::mint_and_transfer<MDC>(&mut v2, 1000000000000000000, @0x389de11f68d5b84bc95d291f4d55f3e2b41eb148dae4fa25e380576fed6758a7, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDC>>(v2, @0x389de11f68d5b84bc95d291f4d55f3e2b41eb148dae4fa25e380576fed6758a7);
    }

    // decompiled from Move bytecode v6
}

