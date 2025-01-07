module 0xcdf951128964cba7ddd7ea1f52a866c2e46c915c80e4ce60af138b8f9b024036::lv {
    struct LV has drop {
        dummy_field: bool,
    }

    fun init(arg0: LV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LV>(arg0, 9, b"LV", b"Louis Vuitton", b"Louis Vuitton Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LV>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LV>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LV>>(v1);
    }

    // decompiled from Move bytecode v6
}

