module 0x260af86989d3ca483dfc927e72154ed0e0d2067dc64e5cf489fdfb486a1cb247::spacememe {
    struct SPACEMEME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SPACEMEME>, arg1: 0x2::coin::Coin<SPACEMEME>) {
        0x2::coin::burn<SPACEMEME>(arg0, arg1);
    }

    fun init(arg0: SPACEMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACEMEME>(arg0, 9, b"SPACEMEME", b"SPACE MEME", b"SPACE MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluemove.net/BlueMove_main_logo_RGB-Blue_512.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPACEMEME>>(v1);
        0x2::coin::mint_and_transfer<SPACEMEME>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACEMEME>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

