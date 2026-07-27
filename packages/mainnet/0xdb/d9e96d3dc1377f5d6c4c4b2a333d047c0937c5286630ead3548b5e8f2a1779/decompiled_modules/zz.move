module 0xdbd9e96d3dc1377f5d6c4c4b2a333d047c0937c5286630ead3548b5e8f2a1779::zz {
    struct ZZ has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZZ>>(0x2::coin::mint<ZZ>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZ>(arg0, 9, b"zz", b"ZZ", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1785151452/sui_tokens/nuybftbayc2saiild0aw.webp"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ZZ>>(0x2::coin::mint<ZZ>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZ>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

