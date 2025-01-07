module 0x84a63547e95dd9b9d286da51ccc60311c3e7461fbce3ada16a21f86578339955::spug {
    struct SPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUG>(arg0, 6, b"SPug", b"SuiPug", b"SuiPug is a fun and lighthearted meme coin on the Sui blockchain, featuring a playful pug as its mascot. With its vibrant and modern design, SuiPug aims to bring humor and excitement to the crypto space while embracing the cutting-edge technology of the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000371_03d34cb0ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

