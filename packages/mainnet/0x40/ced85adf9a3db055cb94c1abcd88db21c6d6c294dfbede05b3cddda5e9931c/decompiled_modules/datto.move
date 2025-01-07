module 0x40ced85adf9a3db055cb94c1abcd88db21c6d6c294dfbede05b3cddda5e9931c::datto {
    struct DATTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DATTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DATTO>(arg0, 9, b"Datto", b"Datto", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DATTO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DATTO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DATTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

