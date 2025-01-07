module 0x846dc84a3b3bddc4613604ebb6498cb6f4dcca0709cdca81dcee6c28e37ff014::hjonk {
    struct HJONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HJONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HJONK>(arg0, 6, b"Hjonk", b"hjonk on sui", b"Theres no financial freedom hereonly a honking market and a broken-hearted wojak.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_logo_192x192_8a25eea2d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HJONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HJONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

