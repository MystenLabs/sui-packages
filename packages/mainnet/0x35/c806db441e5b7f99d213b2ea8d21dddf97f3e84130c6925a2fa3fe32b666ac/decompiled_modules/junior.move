module 0x35c806db441e5b7f99d213b2ea8d21dddf97f3e84130c6925a2fa3fe32b666ac::junior {
    struct JUNIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUNIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUNIOR>(arg0, 9, b"JUNIOR", b"Donald Trump Jr.", x"546865204f6e6c79204f6666696369616c20446f6e616c64205472756d70204a722e20534f4c204d656d652e20244a554e494f522028205472756d70277320536f6e20290a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdePGsMFKx8XuqJ835dWVn7LrJALabmKQSCpzcBZZ2cVH")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JUNIOR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUNIOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUNIOR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

