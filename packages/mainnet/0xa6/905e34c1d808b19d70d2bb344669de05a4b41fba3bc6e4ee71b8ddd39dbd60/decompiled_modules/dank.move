module 0xa6905e34c1d808b19d70d2bb344669de05a4b41fba3bc6e4ee71b8ddd39dbd60::dank {
    struct DANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANK>(arg0, 8, b"DANK", b"DankCash", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvm7_pcu1GPGvzpVPkvba9i9DceKivE4l_xVhIn6RNCWJDsWySLG5zoKGmwFs22UL775I&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DANK>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

