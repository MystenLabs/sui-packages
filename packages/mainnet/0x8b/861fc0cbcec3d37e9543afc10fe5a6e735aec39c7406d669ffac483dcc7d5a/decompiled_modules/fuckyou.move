module 0x8b861fc0cbcec3d37e9543afc10fe5a6e735aec39c7406d669ffac483dcc7d5a::fuckyou {
    struct FUCKYOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKYOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKYOU>(arg0, 6, b"FUCKYOU", b"Washington Redskins", b"Fuck youuuu, fuck youuuu. Fuck you up there! Fuck you! \"Fuck you.\" Those words mean a great deal to us. They help us express just how we as a company... see things differently.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732559955111.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUCKYOU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKYOU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

