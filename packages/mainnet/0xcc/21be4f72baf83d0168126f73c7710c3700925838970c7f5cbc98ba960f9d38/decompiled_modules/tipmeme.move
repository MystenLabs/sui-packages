module 0xcc21be4f72baf83d0168126f73c7710c3700925838970c7f5cbc98ba960f9d38::tipmeme {
    struct TIPMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIPMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIPMEME>(arg0, 9, b"TIPMEME", b"TIPMEME", b"TIP MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://forkast.news/wp-content/uploads/2023/10/Sui-network.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TIPMEME>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIPMEME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIPMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

