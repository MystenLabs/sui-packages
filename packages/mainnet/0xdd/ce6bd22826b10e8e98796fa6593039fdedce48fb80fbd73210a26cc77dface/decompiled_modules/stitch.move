module 0xddce6bd22826b10e8e98796fa6593039fdedce48fb80fbd73210a26cc77dface::stitch {
    struct STITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STITCH>(arg0, 2, b"STITCH", b"STITCH", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bjeyh7ex6gxtvf3bimfe5szlfjxyqr3sojs3uaqcsyigfqcwqtha.arweave.net/CkmD_JfxrzqXYUMKTssrKm-IR3JyZboCApYQYsBWhM4"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STITCH>>(v1);
        0x2::coin::mint_and_transfer<STITCH>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STITCH>>(v2);
    }

    // decompiled from Move bytecode v6
}

