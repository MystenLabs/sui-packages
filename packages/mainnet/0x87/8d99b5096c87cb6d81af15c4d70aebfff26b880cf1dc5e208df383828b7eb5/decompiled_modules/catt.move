module 0x878d99b5096c87cb6d81af15c4d70aebfff26b880cf1dc5e208df383828b7eb5::catt {
    struct CATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATT>(arg0, 9, b"NAME", b"SYMBOL", b"DESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"url")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATT>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATT>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

