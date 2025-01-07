module 0x2713359374e47efa9f0e9b6094a0ae3288f04751b47383c91894f10fa4f770cc::suiptember {
    struct SUIPTEMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPTEMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPTEMBER>(arg0, 9, b"SUIPTEMBER", b"Suiptember", b"letgooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZf5BcWvHeSw2O27Me-8D61TbrPNcaMAPG7Q&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPTEMBER>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPTEMBER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPTEMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

