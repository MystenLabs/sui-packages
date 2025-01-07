module 0xfe58fa496ba10e513eb25bb16b0cad5e3d25adf721407b7718723c9ff8ca6e5d::grin {
    struct GRIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GRIN>(arg0, 6, b"GRIN", b"Cheshire Cat by SuiAI", b"A curious cat, looking to find the balance of meme culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2903_ef4247d1b4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GRIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

