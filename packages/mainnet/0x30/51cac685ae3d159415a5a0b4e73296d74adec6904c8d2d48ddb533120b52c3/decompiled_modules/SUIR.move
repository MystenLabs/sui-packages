module 0x3051cac685ae3d159415a5a0b4e73296d74adec6904c8d2d48ddb533120b52c3::SUIR {
    struct SUIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIR>(arg0, 6, b"SUIR", b"Suirum", b"The Utility Elixir Token Of Suirum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/L63sX383/suirum-logo.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIR>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIR>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

