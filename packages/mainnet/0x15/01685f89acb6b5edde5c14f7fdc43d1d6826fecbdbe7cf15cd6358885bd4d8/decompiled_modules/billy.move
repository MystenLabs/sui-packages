module 0x1501685f89acb6b5edde5c14f7fdc43d1d6826fecbdbe7cf15cd6358885bd4d8::billy {
    struct BILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLY>(arg0, 6, b"BILLY", b"BILLY ON SUI", b"$BILLY has viral potential as its cute asf, he is the most cute dog I have ever see + some $WIF vibes in it. Its easy to edit and all memes are becoming incredibly cute.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730952812992.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BILLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

