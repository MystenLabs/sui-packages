module 0x5381a50e486dbde57ecc7c9c48ad5bcea69dde46f87c0f4aa3607ca8e5bb7c94::ivanka {
    struct IVANKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVANKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IVANKA>(arg0, 6, b"IVANKA", b"OFICIAL IVANKA TRUMP", b"Baby trump meme coin mascot on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027007_eaf746af72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVANKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IVANKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

