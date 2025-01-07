module 0xb9100354df42e07c33eeb4a75d038a2e9e2a82c7b4d9a6751302356f94c275e5::dotcoin {
    struct DOTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOTCOIN>(arg0, 9, b"DOTCOIN", b"DOTCOIN", b"DOTCOIN token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMFQ-QMjSoRCL2GVf2qgGa1SQyDT2VAv5QBg&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOTCOIN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOTCOIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOTCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

