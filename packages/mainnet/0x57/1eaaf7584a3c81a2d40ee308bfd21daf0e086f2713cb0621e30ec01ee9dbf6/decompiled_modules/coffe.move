module 0x571eaaf7584a3c81a2d40ee308bfd21daf0e086f2713cb0621e30ec01ee9dbf6::coffe {
    struct COFFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COFFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COFFE>(arg0, 9, b"COFFE", b"COFFE", b"Like the coffe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPP5-vPe8ktIk_cn9OTlypJRkf14xbkw64gA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COFFE>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COFFE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COFFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

