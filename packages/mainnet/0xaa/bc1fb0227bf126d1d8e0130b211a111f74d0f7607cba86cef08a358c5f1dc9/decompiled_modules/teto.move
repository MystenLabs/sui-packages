module 0xaabc1fb0227bf126d1d8e0130b211a111f74d0f7607cba86cef08a358c5f1dc9::teto {
    struct TETO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETO>(arg0, 4, b"TETO", b"Test Token 1", b"Test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/bd95b100-d70f-11ef-90fe-bb0dc081b6dc")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TETO>>(v1);
        0x2::coin::mint_and_transfer<TETO>(&mut v2, 11000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

