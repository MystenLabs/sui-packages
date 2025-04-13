module 0xc272cb4401b0238f89928ae630bc51a87273b7265e1c88c6e6c0e80535f1af4a::greenky {
    struct GREENKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREENKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREENKY>(arg0, 6, b"GREENKY", b"$GREENKY", b"$GREENKY IS ONE OF THE FIRST CHARACTERS IN THE COLLECTION AND ALSO ONE OF MY FAVORITES I HOPE YOU LIKE IT GOOD LUCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CRYPTO_MONSTERS_COLLECITION_3_1228dd8d82.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREENKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREENKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

