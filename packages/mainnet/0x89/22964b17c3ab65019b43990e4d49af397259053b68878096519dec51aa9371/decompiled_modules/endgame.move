module 0x8922964b17c3ab65019b43990e4d49af397259053b68878096519dec51aa9371::endgame {
    struct ENDGAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENDGAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENDGAME>(arg0, 9, b"ENDGAME", b"Avengers: Endgame", b"The epic conclusion of the Infinity Saga", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://platform.polygon.com/wp-content/uploads/sites/2/chorus/uploads/chorus_asset/file/11614195/InfinityWar5aabd55fed5fa.jpg?quality=90&strip=all&crop=0,15.793333333333,100,45.013333333333")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ENDGAME>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENDGAME>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENDGAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

