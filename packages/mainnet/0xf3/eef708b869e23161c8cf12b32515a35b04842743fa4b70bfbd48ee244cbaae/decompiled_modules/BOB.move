module 0xf3eef708b869e23161c8cf12b32515a35b04842743fa4b70bfbd48ee244cbaae::BOB {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::try_string(b"https://i.imgur.com/pxEsw8w.png");
        let (v1, v2) = 0x2::coin::create_currency<BOB>(arg0, 6, b"BOB", b"", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::option::get_with_default<0x1::ascii::String>(&v0, 0x1::ascii::string(b"")))), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOB>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BOB>>(0x2::coin::mint<BOB>(&mut v3, 1000000000000000000, arg1), @0x7b3c5d549871784c7a9aaf06970698b9c7a7acaf23171d6f1f0de4094176225b);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BOB>>(v3);
    }

    // decompiled from Move bytecode v6
}

