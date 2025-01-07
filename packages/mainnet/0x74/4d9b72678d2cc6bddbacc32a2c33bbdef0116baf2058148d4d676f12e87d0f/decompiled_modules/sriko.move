module 0x744d9b72678d2cc6bddbacc32a2c33bbdef0116baf2058148d4d676f12e87d0f::sriko {
    struct SRIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRIKO>(arg0, 6, b"SRIKO", b"SUI RIKO", x"536f2c206f6e65206461792c2066756e206d657420636f75726167652c20616e642074686174277320686f7720245352494b4f2c20666561726c65737320686f6e6579206261646765722c2077617320626f726e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hihihihihihih_cf66c6994a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

