module 0x65980848439c0a56f458cc69f96284398fe0609d23191888a96e1f70764a1a24::sugar {
    struct SUGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGAR>(arg0, 9, b"SUGAR", x"f09f8dac5375676172", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUGAR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGAR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

