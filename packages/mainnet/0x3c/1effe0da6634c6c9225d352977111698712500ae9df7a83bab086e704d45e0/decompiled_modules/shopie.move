module 0x3c1effe0da6634c6c9225d352977111698712500ae9df7a83bab086e704d45e0::shopie {
    struct SHOPIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOPIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOPIE>(arg0, 6, b"SHOPIE", b"The Sophie Coin", b"Its time to fight back against blood sucking OF models and save the bros", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_200150_272_73a0522dd9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOPIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOPIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

