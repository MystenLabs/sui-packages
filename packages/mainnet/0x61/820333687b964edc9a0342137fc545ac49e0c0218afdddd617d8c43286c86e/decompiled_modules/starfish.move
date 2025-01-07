module 0x61820333687b964edc9a0342137fc545ac49e0c0218afdddd617d8c43286c86e::starfish {
    struct STARFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARFISH>(arg0, 6, b"STARFISH", b"SUISTARFISH", b"Have a nice day!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018283_32ef0f8bdc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

