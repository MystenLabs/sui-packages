module 0xf82b1133cd69be9566efdd2b9f82c2e8da49de2547ff4647dd4276546a84538b::slion {
    struct SLION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLION>(arg0, 6, b"SLION", b"Suillon", b"The OG SUILION... Hear me roar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_fc5178ab56.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLION>>(v1);
    }

    // decompiled from Move bytecode v6
}

