module 0xbb8795af10882bf9acf084c68bdd2a586eb8b76732f1f63960b973b7373e9599::suepe {
    struct SUEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUEPE>(arg0, 6, b"Suepe", b"Pepe on Sui", b"The official Pepe on Sui by Pepe whale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0801_b95571c99b_a4ca2fe59f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

