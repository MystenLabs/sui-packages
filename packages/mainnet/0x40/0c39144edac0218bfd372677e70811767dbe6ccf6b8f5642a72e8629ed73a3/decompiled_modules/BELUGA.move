module 0x400c39144edac0218bfd372677e70811767dbe6ccf6b8f5642a72e8629ed73a3::BELUGA {
    struct BELUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::try_string(b"https://i.imgur.com/PPxS0rD.png");
        let (v1, v2) = 0x2::coin::create_currency<BELUGA>(arg0, 6, b"BELU", b"BELUGA", b"BELUGA - Your life change chance ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::option::get_with_default<0x1::ascii::String>(&v0, 0x1::ascii::string(b"")))), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BELUGA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BELUGA>>(0x2::coin::mint<BELUGA>(&mut v3, 1000000000000000, arg1), @0x7b3c5d549871784c7a9aaf06970698b9c7a7acaf23171d6f1f0de4094176225b);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BELUGA>>(v3);
    }

    // decompiled from Move bytecode v6
}

