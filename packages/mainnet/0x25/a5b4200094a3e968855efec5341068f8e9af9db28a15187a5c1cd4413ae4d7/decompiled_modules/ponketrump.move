module 0x25a5b4200094a3e968855efec5341068f8e9af9db28a15187a5c1cd4413ae4d7::ponketrump {
    struct PONKETRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKETRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKETRUMP>(arg0, 9, b"PonkeTrump", b"PonkeTrump", b"PonkeTrump Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PONKETRUMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PONKETRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKETRUMP>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

