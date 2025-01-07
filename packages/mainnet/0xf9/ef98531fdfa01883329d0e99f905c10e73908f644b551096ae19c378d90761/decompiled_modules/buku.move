module 0xf9ef98531fdfa01883329d0e99f905c10e73908f644b551096ae19c378d90761::buku {
    struct BUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUKU>(arg0, 6, b"BUKU", b"Buku Sui Dollars", b"Buku Sui Dollars going straight to Mars, rest stop at the moon! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001799_70aa9e8463.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

