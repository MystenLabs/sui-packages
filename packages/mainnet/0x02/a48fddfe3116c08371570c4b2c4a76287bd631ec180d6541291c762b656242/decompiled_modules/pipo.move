module 0x2a48fddfe3116c08371570c4b2c4a76287bd631ec180d6541291c762b656242::pipo {
    struct PIPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPO>(arg0, 6, b"Pipo", b"Pipo", b"Pipo pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAnhF8fGMoiIAibLe8tkdeJEBQWE3PKP3c5w&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIPO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

