module 0x8b65b99779036f104af3f39c135c3bbeee819ae11340291d7bd65fb7834960ad::mkoa {
    struct MKOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKOA>(arg0, 6, b"MKOA", b"MINTY KOALA", b"Fresh, cuddly, and surprisingly feisty. Minty Koala is here to mint memes and melt wallets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_031718955_5f27a7b9fd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MKOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

