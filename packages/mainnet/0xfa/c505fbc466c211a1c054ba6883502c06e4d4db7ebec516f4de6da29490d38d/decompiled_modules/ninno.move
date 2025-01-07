module 0xfac505fbc466c211a1c054ba6883502c06e4d4db7ebec516f4de6da29490d38d::ninno {
    struct NINNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINNO>(arg0, 9, b"NINNO", b"Ninno", b"Ninno is a unique, water-inspired token name symbolizing fluidity and innovation. Its playful sound and fresh vibe make it perfect for a dynamic digital currency ready to make waves in the market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1810250205201145856/37XPcSwn.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NINNO>(&mut v2, 300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINNO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NINNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

