module 0x550131382cd4b4e29edfedac88362a1c5fcb37fcc698e8f048dff78d831f5f48::pxpep {
    struct PXPEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXPEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PXPEP>(arg0, 6, b"PXPEP", b"PIXEL PEPE", b"GAME PIXEL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2022_02_05_09_33_02_074329cc43.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PXPEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PXPEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

