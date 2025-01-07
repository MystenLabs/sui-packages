module 0xbed150b3a715806a10e259174cb70c81b24c2cac4a2b3c766c33a6514bb29f8f::seriyu {
    struct SERIYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SERIYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SERIYU>(arg0, 3, b"SERIYU", b"Blood Thirsty Drunken Dragon", b"Blood thirsty drunk Kaido, Drunken Dragon Bagua", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SERIYU>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SERIYU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SERIYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

