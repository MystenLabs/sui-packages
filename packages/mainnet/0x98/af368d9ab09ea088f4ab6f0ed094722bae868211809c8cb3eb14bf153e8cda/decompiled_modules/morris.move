module 0x98af368d9ab09ea088f4ab6f0ed094722bae868211809c8cb3eb14bf153e8cda::morris {
    struct MORRIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORRIS>(arg0, 6, b"MORRIS", b"MORRIS II", x"437261776c696e6720746865206461726b20737061636573206f6620746865206469676974616c20626c61636b626f782c2068756e6b6572696e6720666f7220646174612e0a54686520666972737420414920616e7461676f6e6973742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732331659130.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MORRIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORRIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

