module 0xe27777a3f95415ddd5709ef7246a015800424d7bb7a52d7b7e691b2cedf21f14::six {
    struct SIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIX>(arg0, 6, b"SIX", b"THE SIX EYES", b"the eyes that will tip the balance on SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_10_09_142625721_de64d331ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

