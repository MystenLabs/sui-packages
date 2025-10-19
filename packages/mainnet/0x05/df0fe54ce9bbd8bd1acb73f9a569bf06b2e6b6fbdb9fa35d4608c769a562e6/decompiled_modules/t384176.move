module 0x5df0fe54ce9bbd8bd1acb73f9a569bf06b2e6b6fbdb9fa35d4608c769a562e6::t384176 {
    struct T384176 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T384176, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T384176>(arg0, 9, b"T384176", b"Test 384176", b"Integration test token 2025-10-19T22:53:04.176Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T384176>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T384176>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

