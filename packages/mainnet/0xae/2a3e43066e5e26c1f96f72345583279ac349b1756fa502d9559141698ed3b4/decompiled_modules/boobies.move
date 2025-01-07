module 0xae2a3e43066e5e26c1f96f72345583279ac349b1756fa502d9559141698ed3b4::boobies {
    struct BOOBIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBIES>(arg0, 9, b"BOOBIES", x"2820e0b98f20e4baba20e0b98f2029424f4f42494553", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOBIES>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBIES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOBIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

