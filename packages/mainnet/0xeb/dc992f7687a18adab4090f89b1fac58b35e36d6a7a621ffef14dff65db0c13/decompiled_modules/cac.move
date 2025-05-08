module 0xebdc992f7687a18adab4090f89b1fac58b35e36d6a7a621ffef14dff65db0c13::cac {
    struct CAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAC>(arg0, 9, b"CAC", b"CAC", b"CAC CAC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CAC>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAC>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

