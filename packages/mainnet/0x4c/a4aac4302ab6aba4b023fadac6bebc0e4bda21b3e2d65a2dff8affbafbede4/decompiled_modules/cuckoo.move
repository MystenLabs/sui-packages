module 0x4ca4aac4302ab6aba4b023fadac6bebc0e4bda21b3e2d65a2dff8affbafbede4::cuckoo {
    struct CUCKOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUCKOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUCKOO>(arg0, 6, b"CUCKOO", b"Cuckoo", b"Cuckoo is a good friend of human beings. We all love cuckoo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2040_png_1200_19a8d5a5a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUCKOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUCKOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

