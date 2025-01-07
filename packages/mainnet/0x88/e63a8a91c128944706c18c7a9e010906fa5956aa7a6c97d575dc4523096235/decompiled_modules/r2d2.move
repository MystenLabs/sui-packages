module 0x88e63a8a91c128944706c18c7a9e010906fa5956aa7a6c97d575dc4523096235::r2d2 {
    struct R2D2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: R2D2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R2D2>(arg0, 6, b"R2D2", b"R2D2 AI", b"A revolutionary virtual assistant focused on helping developers on the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000523_98969115ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R2D2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<R2D2>>(v1);
    }

    // decompiled from Move bytecode v6
}

