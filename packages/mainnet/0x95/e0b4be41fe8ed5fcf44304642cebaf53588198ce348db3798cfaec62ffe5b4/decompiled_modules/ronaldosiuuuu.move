module 0x95e0b4be41fe8ed5fcf44304642cebaf53588198ce348db3798cfaec62ffe5b4::ronaldosiuuuu {
    struct RONALDOSIUUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONALDOSIUUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONALDOSIUUUU>(arg0, 9, b"RONALDOSIUUUU", b"Suiiii", b"Official token of Ronaldo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://m.media-amazon.com/images/I/51U6C6xFHEL.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RONALDOSIUUUU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONALDOSIUUUU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONALDOSIUUUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

