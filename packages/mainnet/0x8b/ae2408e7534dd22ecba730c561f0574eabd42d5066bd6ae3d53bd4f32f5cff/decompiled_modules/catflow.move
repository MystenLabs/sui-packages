module 0x8bae2408e7534dd22ecba730c561f0574eabd42d5066bd6ae3d53bd4f32f5cff::catflow {
    struct CATFLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATFLOW>(arg0, 6, b"CATFLOW", b"CAT FLOWER", b"beauty Cat Flower, let's take care of it, SUI DEGEN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3696_8a7aa52129.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATFLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

