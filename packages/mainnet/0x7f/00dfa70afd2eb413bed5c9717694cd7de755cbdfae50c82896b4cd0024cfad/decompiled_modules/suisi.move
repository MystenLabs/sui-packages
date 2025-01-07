module 0x7f00dfa70afd2eb413bed5c9717694cd7de755cbdfae50c82896b4cd0024cfad::suisi {
    struct SUISI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISI>(arg0, 6, b"SUISI", b"SUISI CAT", b"$SUISI The Sui Cat that's too cool for the block, straight flexing on the blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5175_658b360ab0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISI>>(v1);
    }

    // decompiled from Move bytecode v6
}

