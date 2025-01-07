module 0x78f9c06e0b9fcb40d8a3e70712971dea25b4ee40ff972e8243ca3cbee65ab764::cfai {
    struct CFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFAI>(arg0, 6, b"CFAI", b"Chicken frog", b"Chicken from AI. \"he who holds will be richer than he who sol ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_4ee4f90cf3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CFAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

