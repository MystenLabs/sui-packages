module 0x7da53a971ed67307354161f8b4be00dc28043dab634a46910ebcbc82184abaca::mudkip {
    struct MUDKIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUDKIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUDKIP>(arg0, 6, b"Mudkip", b"Mudkip On Sui", b"Cutest Mudkip on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958318690.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUDKIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUDKIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

