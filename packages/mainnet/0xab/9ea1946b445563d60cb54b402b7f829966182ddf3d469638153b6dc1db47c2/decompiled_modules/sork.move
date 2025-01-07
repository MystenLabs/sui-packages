module 0xab9ea1946b445563d60cb54b402b7f829966182ddf3d469638153b6dc1db47c2::sork {
    struct SORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SORK>(arg0, 6, b"SORK", b"BORK", b"BORK on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_21_18_26_4d8cd29636.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

