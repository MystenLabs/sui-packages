module 0xe984c74a039196cb5ad59120e8cb1e862e229b9bdca3a8f426b7f7b24f044ef::sveiki {
    struct SVEIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVEIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVEIKI>(arg0, 6, b"Sveiki", b"Svejki", b"Laba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_11_22_43_06_d016e20217.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVEIKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SVEIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

