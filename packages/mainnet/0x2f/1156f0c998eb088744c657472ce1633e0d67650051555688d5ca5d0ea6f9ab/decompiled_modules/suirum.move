module 0x2f1156f0c998eb088744c657472ce1633e0d67650051555688d5ca5d0ea6f9ab::suirum {
    struct SUIRUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRUM>(arg0, 6, b"SUIR", b"Suirum", b"The Utility Elixir Token Of Suirum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/L63sX383/suirum-logo.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIRUM>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIRUM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRUM>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

