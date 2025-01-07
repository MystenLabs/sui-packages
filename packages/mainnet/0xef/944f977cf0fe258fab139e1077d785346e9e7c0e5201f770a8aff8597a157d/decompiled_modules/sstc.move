module 0xef944f977cf0fe258fab139e1077d785346e9e7c0e5201f770a8aff8597a157d::sstc {
    struct SSTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSTC>(arg0, 6, b"SSTC", b"SuiStitch", b"Stitch is very cute that everone love IT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/th_86b9bf3175.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

