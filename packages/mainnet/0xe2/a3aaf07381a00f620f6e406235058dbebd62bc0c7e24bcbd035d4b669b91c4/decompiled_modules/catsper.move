module 0xe2a3aaf07381a00f620f6e406235058dbebd62bc0c7e24bcbd035d4b669b91c4::catsper {
    struct CATSPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSPER>(arg0, 6, b"CATSPER", b"Ghostcats", b"$Ghostcat, known as $GhostCat, a spectral presence haunting moonlit alleys with ethereal grace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043991_280cfe4a93.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

