module 0xc5e98ebb5f091a9435e001d17b8dcb2c9c709784368248c5f3dc9cb0d658ccab::rabitlol {
    struct RABITLOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABITLOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABITLOL>(arg0, 6, b"RABITLOL", b"RABIT", x"524142495420282452414249544c4f4c290a466f6c6c6f77207468652052414249542c20616e6420746865206a6f75726e657920626567696e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734226153359.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RABITLOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABITLOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

