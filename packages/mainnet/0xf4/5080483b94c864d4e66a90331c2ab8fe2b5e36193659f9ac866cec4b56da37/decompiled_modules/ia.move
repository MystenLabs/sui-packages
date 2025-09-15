module 0xf45080483b94c864d4e66a90331c2ab8fe2b5e36193659f9ac866cec4b56da37::ia {
    struct IA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IA>(arg0, 6, b"IA", b"GAIA", x"476169612069732074686520706572736f6e696669636174696f6e206f6620456172746820616e642074686520616e6365737472616c206d6f74686572206f6620616c6c206c6966652e2e2e0a0a4e6f772c20746865206d6f74686572206f6620616c6c204d454d4553206f6e207468652053554920626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1757947728127.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

