module 0x9bc214c0c24c0d37cfcc702b8eddaae04e4f5cfcbc72a9015189fc66e30b74db::usahealthcare {
    struct USAHEALTHCARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: USAHEALTHCARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USAHEALTHCARE>(arg0, 6, b"USAHealthcare", b"USA Universal Healthcare", b"The United States the Greatest Country in the World! should have universal healthcare to ensure that all citizens, regardless of income or employment status, have access to essential medical services, fostering a healthier and more productive society. Universal healthcare would reduce financial burdens on families by eliminating crippling medical debts and high insurance costs, while also lowering administrative expenses associated with private insurance. Additionally, it aligns with the principles of equality and human dignity, affirming that healthcare is a fundamental right rather than a privilege.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/usa_health11_0687cd5bff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USAHEALTHCARE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USAHEALTHCARE>>(v1);
    }

    // decompiled from Move bytecode v6
}

