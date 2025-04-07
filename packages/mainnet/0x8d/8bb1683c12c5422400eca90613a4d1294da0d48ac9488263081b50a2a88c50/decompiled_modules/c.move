module 0x8d8bb1683c12c5422400eca90613a4d1294da0d48ac9488263081b50a2a88c50::c {
    struct C has drop {
        dummy_field: bool,
    }

    fun init(arg0: C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C>(arg0, 9, b"C", b"Capybara", b"Capybara Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/dceb01362b50918f048182b9569dd112blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<C>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

