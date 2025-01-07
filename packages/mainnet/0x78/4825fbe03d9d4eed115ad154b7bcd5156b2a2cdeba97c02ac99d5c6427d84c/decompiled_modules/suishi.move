module 0x784825fbe03d9d4eed115ad154b7bcd5156b2a2cdeba97c02ac99d5c6427d84c::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 6, b"SUISHI", b"SuishiCat", b"Once upon a time, in a world where sushi and cats coexisted in a state of blissful harmony, something magical happened. In the high-speed universe of the Sui, a cosmic glitch caused a fusion of epic proportions: out popped *Suishicat*", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suishicat_2368ff0021.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

