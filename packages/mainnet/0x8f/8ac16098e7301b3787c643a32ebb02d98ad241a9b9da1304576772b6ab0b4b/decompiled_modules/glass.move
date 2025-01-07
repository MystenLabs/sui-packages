module 0x8f8ac16098e7301b3787c643a32ebb02d98ad241a9b9da1304576772b6ab0b4b::glass {
    struct GLASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLASS>(arg0, 6, b"GLASS", b"SUI-GLASS", b"SUI-GLASS TO THE MOON!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bicchiere_4bf9613803.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

