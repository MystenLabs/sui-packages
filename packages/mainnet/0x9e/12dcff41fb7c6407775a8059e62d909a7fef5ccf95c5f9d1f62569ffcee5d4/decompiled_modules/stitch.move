module 0x9e12dcff41fb7c6407775a8059e62d909a7fef5ccf95c5f9d1f62569ffcee5d4::stitch {
    struct STITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STITCH>(arg0, 6, b"STITCH", b"SuiStitch", b"World's cutets chaos. Me landed on sui. Stitch!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaxo7rhezlbo2rpvhyplpa7omyo6t4rdiervdnnkzbjliozdhypva")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STITCH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

