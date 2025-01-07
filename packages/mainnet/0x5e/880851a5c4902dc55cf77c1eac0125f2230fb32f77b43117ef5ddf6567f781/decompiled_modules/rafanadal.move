module 0x5e880851a5c4902dc55cf77c1eac0125f2230fb32f77b43117ef5ddf6567f781::rafanadal {
    struct RAFANADAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAFANADAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAFANADAL>(arg0, 6, b"RAFANADAL", b"BYE RAFA", b"Meme dedicated to one of the greatest ever...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1a655535eb5967372be33fee521f92a3_ebc757fb78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAFANADAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAFANADAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

