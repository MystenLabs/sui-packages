module 0x884f4c75bb54dcab2729092ad9c6565f3859a4e752a9004de7b828f6341eb694::fckansem {
    struct FCKANSEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCKANSEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCKANSEM>(arg0, 6, b"FCKANSEM", b"fck ansem", x"62726f207265616c6c792074686f7567687420686520636f756c6420737072656164206675642061626f7574205355492c20626967204c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1d3288e05d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCKANSEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCKANSEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

