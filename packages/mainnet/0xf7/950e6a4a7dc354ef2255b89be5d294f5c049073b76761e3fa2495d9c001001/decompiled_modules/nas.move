module 0xf7950e6a4a7dc354ef2255b89be5d294f5c049073b76761e3fa2495d9c001001::nas {
    struct NAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAS>(arg0, 6, b"NAS", b"New Ath SUI", b"New Ath SUI LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_cointribune_13_34196786ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

