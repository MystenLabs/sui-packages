module 0xe3f956eddd6ae23b98de2a4b0c49ce38fd0f531cc5c6780dc9f824f1ae50dcdf::testo {
    struct TESTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTO>(arg0, 6, b"TESTO", b"testo", b"testomax", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_43df1e38b4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

