module 0x2d5f7adbe83bd1e79e25bc8d86365ee2adbf338dfad121ce9150ece5aff78d97::MOTVIK {
    struct MOTVIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTVIK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::try_string(b"https://i.imgur.com/i4HMu66.jpeg");
        let (v1, v2) = 0x2::coin::create_currency<MOTVIK>(arg0, 6, b"MOTVE", b"", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::option::get_with_default<0x1::ascii::String>(&v0, 0x1::ascii::string(b"")))), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOTVIK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOTVIK>>(0x2::coin::mint<MOTVIK>(&mut v3, 1000000000000000, arg1), @0x7b3c5d549871784c7a9aaf06970698b9c7a7acaf23171d6f1f0de4094176225b);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOTVIK>>(v3);
    }

    public fun swap_a2b() {
        abort 1
    }

    // decompiled from Move bytecode v6
}

