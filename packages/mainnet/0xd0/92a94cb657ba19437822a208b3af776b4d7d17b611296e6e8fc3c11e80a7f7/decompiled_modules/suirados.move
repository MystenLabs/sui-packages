module 0xd092a94cb657ba19437822a208b3af776b4d7d17b611296e6e8fc3c11e80a7f7::suirados {
    struct SUIRADOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRADOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRADOS>(arg0, 6, b"SUIRADOS", b"Suirados", b"Suirados is known to be extremely violent, often flying into an outrage and destroying all the red candles and jeets. Don't stay being a Magikarp, become a Suirados! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suirados_5d8f0df08b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRADOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRADOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

