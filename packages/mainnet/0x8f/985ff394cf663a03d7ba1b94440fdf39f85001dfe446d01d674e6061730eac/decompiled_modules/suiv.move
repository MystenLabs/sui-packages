module 0x8f985ff394cf663a03d7ba1b94440fdf39f85001dfe446d01d674e6061730eac::suiv {
    struct SUIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIV>(arg0, 6, b"SUIV", b"Suiii Victory", b"And it's suiii, suiii, suiii victory, YEAH!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0357_e4ab6b5f4a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIV>>(v1);
    }

    // decompiled from Move bytecode v6
}

