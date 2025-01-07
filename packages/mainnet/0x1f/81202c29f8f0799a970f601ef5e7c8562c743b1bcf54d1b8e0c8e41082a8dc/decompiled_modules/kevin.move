module 0x1f81202c29f8f0799a970f601ef5e7c8562c743b1bcf54d1b8e0c8e41082a8dc::kevin {
    struct KEVIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEVIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEVIN>(arg0, 6, b"Kevin", b"Kevin The Sui Cucumber", b"The ultimate meme from under the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4296_42a904ac04.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEVIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEVIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

