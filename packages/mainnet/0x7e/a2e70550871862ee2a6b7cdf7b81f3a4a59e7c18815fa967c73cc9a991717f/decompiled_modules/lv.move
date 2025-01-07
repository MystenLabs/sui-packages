module 0x7ea2e70550871862ee2a6b7cdf7b81f3a4a59e7c18815fa967c73cc9a991717f::lv {
    struct LV has drop {
        dummy_field: bool,
    }

    fun init(arg0: LV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LV>(arg0, 7, b"LV", b"Louis", b"Louis Vuitton", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.app.goo.gl/fWuJJ4rE6LDGya5y5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LV>(&mut v2, 70000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LV>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LV>>(v1);
    }

    // decompiled from Move bytecode v6
}

