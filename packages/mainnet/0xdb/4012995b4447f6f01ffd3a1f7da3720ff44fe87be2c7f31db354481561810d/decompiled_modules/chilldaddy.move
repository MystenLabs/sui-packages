module 0xdb4012995b4447f6f01ffd3a1f7da3720ff44fe87be2c7f31db354481561810d::chilldaddy {
    struct CHILLDADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLDADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLDADDY>(arg0, 6, b"CHILLDADDY", b"CHILLDADDY ON SUI", x"4e4f57204c495645204f4e2053554920636861696e2e204a6f696e20746865206d6f76656d656e7420616e642067726162206120626167206f66204348494c4c44414444593a206368696c6c64616464796f6e7375692e66756e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_364e2b25a0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLDADDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLDADDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

