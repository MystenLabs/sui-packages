module 0x73fa2c634e1a55ab543b45da3373590a917b10e83880b5a8efd088d51b1dff91::demon {
    struct DEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMON>(arg0, 6, b"DEMON", b"SATANSUI", b"SATANNNNSUIII DEMON SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e4f60d024b6029ba9fb02be9ede89816_0016106cfc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

