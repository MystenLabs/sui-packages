module 0x46e9a62b7be80be204c85e8aa489938dea59290172cbee6cdd5d85310bfa0576::slion {
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

