module 0x7359e82776e93c3fa906c82a743e6769238835f39cb904dacc62d033f976f251::fudpug {
    struct FUDPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDPUG>(arg0, 6, b"FUDPUG", b"FUD THE PUG", b"FUD is the lucky pug of Sui Network. Made by the community, for the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_222612973_5e736fb3f1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

