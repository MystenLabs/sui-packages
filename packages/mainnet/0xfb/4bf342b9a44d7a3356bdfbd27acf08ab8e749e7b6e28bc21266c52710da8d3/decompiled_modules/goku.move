module 0xfb4bf342b9a44d7a3356bdfbd27acf08ab8e749e7b6e28bc21266c52710da8d3::goku {
    struct GOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKU>(arg0, 6, b"Goku", b"GokuMemeSUI", b"$GOKU is not just a cryptocurrency; it's a fusion of humor, innovation, and the limitless potential of the blockchain. Just like Goku's determination to become the strongest martial artist in the universe, $GOKU strives to become the most entertainin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950370724.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

