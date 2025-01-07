module 0x8ff05fb36ed7f35c5f7abd1780369fcb30d5ced3c9bca6459be09ccd19e709dc::srm {
    struct SRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRM>(arg0, 6, b"Srm", b"Suiron man", b"The suironman on #sui taking us to the moon!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0750_c61e9511bd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

