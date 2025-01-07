module 0x9f7bd5937c84eeff9e9b10ea2fb8585fca0228336680e6d042ac066e176d5f10::kuromi {
    struct KUROMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUROMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUROMI>(arg0, 6, b"KUROMi", b"KUROMI", b"Kuromi (, Kuromi) is a character from the My Melody universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728712824759_6fb4cfe3b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUROMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUROMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

