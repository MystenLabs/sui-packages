module 0xddd23f397bcbb5a11068e19c7290cfec64f02ea80c8dfd55d9938fab71698ccf::sin {
    struct SIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SIN>(arg0, 6, b"SIN", b"SINVERSE by SuiAI", b"Sinverse is a mysterious and immersive platform where sins are judged, measured, and forever inscribed on the blockchain. Powered by the Infernal Intelligence, it evaluates confessions, assigning a weight to each sin, revealing its true depth. $SIN is the essence of this forbidden system, driving judgment, purification, and evolution. Together, Sinverse and $SIN transform the act of confession into a journey of eternal transmutation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/hero_img_0277ba51_ee2ef8967f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

